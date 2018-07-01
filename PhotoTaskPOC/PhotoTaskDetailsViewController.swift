//
//  PhotoTaskViewController.swift
//  Pegasus
//
//  Created by Matthew Lintlop on 6/18/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit
import AVFoundation
import MobileCoreServices

class PhotoTaskDetailsViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private struct Constants {
        static let topAnchorOffset: CGFloat = 10
    }
    
    @IBOutlet weak var photoTaskTitleLabel: UILabel!
    @IBOutlet weak var photoTaskLocationLabel: UILabel!
    @IBOutlet weak var photoTaskInstructionsTextField: UITextView!
    
    @IBOutlet weak var photosStackView: UIStackView!
    @IBOutlet weak var lowerSectionView: UIView!
    @IBOutlet weak var submitPhotoTaskButton: UIButton!
    @IBOutlet weak var photosStackViewContentWidthConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var photosScrollView: UIScrollView!
    var imagePicker: UIImagePickerController?
    
    @IBOutlet weak var addPhotoButton: UIButton!
    
    @IBOutlet weak var scrollViewContentView: UIView!
    
    let placeHolderText = "PhotoTask.StoreNotes.DefaultText".localized
    let layerCornerRadius: CGFloat = 8.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoTaskInstructionsTextField.delegate = self
        
        photoTaskInstructionsTextField.text = placeHolderText
        photoTaskInstructionsTextField.textColor = UIColor.lightGray
        
        submitPhotoTaskButton.layer.cornerRadius = layerCornerRadius
        
        addPhotoButton.layer.cornerRadius = layerCornerRadius
        addPhotoButton.clipsToBounds = true
        setupStackView()
    }
     
    func setupStackView() {
        let viewHeight = photosScrollView.bounds.size.height
        let viewWidth = photosScrollView.bounds.size.width
        let frame = CGRect(x: 0, y: 0, width: viewWidth, height: viewHeight)
        let photoView = UIView(frame: frame)
        
        let widthConstraint = photoView.widthAnchor.constraint(lessThanOrEqualToConstant: viewWidth)
        let heightConstraint = photoView.heightAnchor.constraint(equalToConstant: viewHeight)
        NSLayoutConstraint.activate([
            widthConstraint,
            heightConstraint
            ])

        photoView.backgroundColor = UIColor.clear
        photosStackView.insertArrangedSubview(photoView, at: 0)
        setAutoLayoutConstraints()
    }

    func addPhoto(withImage image: UIImage) {
        let stackViewSize = photosStackView.bounds.size
        let height = stackViewSize.height
        let photoImageFrame = CGRect(x: 0, y: 0, width: height, height: height)
        let photoView = PhotoTaskPhotoView(frame: photoImageFrame)
        guard let mainView = photoView.photoView else {
            print("Error PhotoView mainView not found")
            return
        }
        guard let photoImageView = photoView.photoImageView else {
            print("Error PhotoView photoImageView not found")
           return
        }
        photoView.delegate = self
        photoImageView.image = image
        mainView.layer.cornerRadius = layerCornerRadius
        mainView.clipsToBounds = true
        let widthConstraint = mainView.widthAnchor.constraint(equalToConstant: height)
        let heightConstraint = mainView.heightAnchor.constraint(equalToConstant: height)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])
        photosStackView.insertArrangedSubview(mainView, at: 0)
        setAutoLayoutConstraints()
    }
   
    private func setAutoLayoutConstraints() {
        guard photosStackView != nil else {
            return
        }
        let scrollViewWidth = photosScrollView.frame.size.width
        let subViewCount = photosStackView.arrangedSubviews.count
        if (subViewCount == 0) {
            photosStackViewContentWidthConstraint.constant = scrollViewWidth
        }
        else {
            let photoViewWidth = photosStackView.arrangedSubviews.first!.bounds.size.width
            let totalSpacing:CGFloat = CGFloat(subViewCount-1) * photosStackView.spacing
            var stackViewtWidth: CGFloat = (CGFloat(subViewCount-1) * photoViewWidth) + totalSpacing
            stackViewtWidth = max(stackViewtWidth, scrollViewWidth)
            photosStackViewContentWidthConstraint.constant = stackViewtWidth
        }
    }
    
    @IBAction func submitPhotoTaskPressed(_ sender: Any) {
        print("Submit Photo Task Pressed")
    }
    
    @IBAction func addPhotoPressed(_ sender: Any) {
        requestCameraAccess()
    }
    
    func takePhoto() {
        imagePicker =  UIImagePickerController()
        guard let imagePicker = imagePicker else {
            return
        }
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.mediaTypes =  [kUTTypeImage as String]
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        present(imagePicker,animated: true,completion: nil)
    }
    
    func requestCameraAccess() {
        guard UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) else {
            print("The Simulator does not have a camera.")
            return
        }
        
        AVCaptureDevice.requestAccess(for: AVMediaType.video) { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.takePhoto()
                } else {
                    let alert = UIAlertController(title: "Camera", message: "Camera access is required to use this application", preferredStyle: UIAlertControllerStyle.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
                    }))
                    self?.present(alert, animated: true)
                }
            }
        }
    }
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let photoImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        addPhoto(withImage: photoImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Image picker did cancel.")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        
        textView.textColor = .black
        
        if(textView.text == placeHolderText) {
            textView.text = ""
        }
        
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if(textView.text == "") {
            textView.text = placeHolderText
            textView.textColor = .lightGray
        }
     }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        return true
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        print("Close pressed.")
    }
    
    // MARK: Debugging
    
    private func debugScrolling() {
        print(".......................................................")
        print("photosStackViewContentWidthConstraint = \(photosStackViewContentWidthConstraint)")
        print("# arranged subviews: \(photosStackView.arrangedSubviews.count)")
        
        let scrollViewBounds = photosScrollView.bounds
        print("scrollViewBounds size = \(scrollViewBounds.size)")
        
        let stackViewBounds = photosStackView.bounds
        print("stackViewBounds size = \(stackViewBounds.size)")
        
        let contentBounds = scrollViewContentView.bounds
        print("contentBounds size = \(contentBounds.size)")
    }

}

extension PhotoTaskDetailsViewController: CardViewControllerDelegate {
    
    func heightForCardHeader(cardViewController: CardViewController) -> CGFloat {
        return Constants.topAnchorOffset
    }
}

// MARK: PhotoTaskPhotoViewDelegate

extension PhotoTaskDetailsViewController: PhotoTaskPhotoViewDelegate {
    
    func photoViewWasDeleted(_ deletedPhotoView: PhotoTaskPhotoView) {
        print("PhotoView was deleted: \(deletedPhotoView)")
    }
}
