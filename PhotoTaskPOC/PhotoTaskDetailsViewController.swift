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
    
    // MARK: Outlets
    
    @IBOutlet weak var photoTaskTitleLabel: UILabel!
    @IBOutlet weak var photoTaskLocationLabel: UILabel!
    @IBOutlet weak var photoTaskInstructionsTextField: UITextView!
    
    @IBOutlet weak var photosStackView: UIStackView!
    @IBOutlet weak var lowerSectionView: UIView!
    @IBOutlet weak var submitPhotoTaskButton: UIButton!
    @IBOutlet weak var photosStackViewContentWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var photosScrollView: UIScrollView!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var scrollViewContentView: UIView!
    
    // MARK: Properties
    
    var imagePicker: UIImagePickerController?
    let placeHolderText = "PhotoTask.StoreNotes.DefaultText".localized
    let layerCornerRadius: CGFloat = 8.0
    
 
    // MARK: View Lifecycle

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

        photoView.backgroundColor = UIColor.green
        photosStackView.insertArrangedSubview(photoView, at: 0)
        setAutoLayoutConstraints()
    }
    
    // MARK: Auto Layout

    private func setAutoLayoutConstraints() {
        guard photosStackView != nil else {
            return
        }
        
        // TODO Count deleted & active Photo Views's
        let deletedPhotoViewCount = photosStackView.arrangedSubviews.reduce(0) { (count, view) -> Int in
            guard let photoView = view as? PhotoTaskPhotoView else {
                return count
            }
            if photoView.isDeleted {
                return count+1
            }
            else {
                return count
            }
        }
        let visiblePhotoViewCount = photosStackView.arrangedSubviews.count-deletedPhotoViewCount
        
        let scrollViewWidth = photosScrollView.frame.size.width
        let subViewCount = photosStackView.arrangedSubviews.count
        if (subViewCount == 0) {
            photosStackViewContentWidthConstraint.constant = 0
        }
        else {
            let photoViewWidth = photosStackView.arrangedSubviews.first!.bounds.size.width
            let totalSpacing:CGFloat = CGFloat(visiblePhotoViewCount-1) * photosStackView.spacing
            var stackViewtWidth: CGFloat = (CGFloat(visiblePhotoViewCount-1) * photoViewWidth) + totalSpacing
            stackViewtWidth = max(stackViewtWidth, scrollViewWidth)
            photosStackViewContentWidthConstraint.constant = stackViewtWidth
        }
        
        print("setAutoLayoutConstraints: deletedPhotoViewCount = \(deletedPhotoViewCount), visiblePhotoViewCount = \(visiblePhotoViewCount), photosStackViewContentWidthConstraint = \(photosStackViewContentWidthConstraint)")
    }
    
    // MARK: Action Handlers
    
    @IBAction func submitPhotoTaskPressed(_ sender: Any) {
        print("Submit Photo Task Pressed")
    }
    
    @IBAction func addPhotoPressed(_ sender: Any) {
        requestCameraAccess()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        print("PhotoTaskDetailsViewController: Close pressed.")
    }
    

    // MARK: Photos
    
    func addPhoto(_ photoImage: UIImage) {
        let stackViewSize = photosStackView.bounds.size
        let height = stackViewSize.height
        
        let storyboard = UIStoryboard(name: "PhotoTask", bundle: nil)
        guard let photoViewController = storyboard.instantiateViewController(withIdentifier: "PhotoTaskPhotoViewController") as? PhotoTaskPhotoViewController else {
            return
        }
        photoViewController.delegate = self
        self.addChildViewController(photoViewController)
        let view = photoViewController.view     // sets IBOutlets in PhotoTaskPhotoViewController
        
        guard let photoView = photoViewController.photoView else {
            print("Error: PhotoTaskPhotoView not found")
            return
        }
        
        guard let photoImageView = photoViewController.photoImageView else {
            print("Error: photoImageView not found")
            return
        }
        photoImageView.image = photoImage
        photoView.layer.cornerRadius = layerCornerRadius
        photoView.clipsToBounds = true
        let widthConstraint = photoView.widthAnchor.constraint(lessThanOrEqualToConstant: height)
        let heightConstraint = photoView.heightAnchor.constraint(equalToConstant: height)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint])
        photosStackView.insertArrangedSubview(photoView, at: 0)
        setAutoLayoutConstraints()
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
        addPhoto(photoImage)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Image picker did cancel.")
        picker.dismiss(animated: true, completion: nil)
    }
    
    // MARK: UITextViewDelegate
    
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
}

extension PhotoTaskDetailsViewController: CardViewControllerDelegate {
    
    func heightForCardHeader(cardViewController: CardViewController) -> CGFloat {
        return Constants.topAnchorOffset
    }
}

// MARK: PhotoTaskPhotoViewDelegate

extension PhotoTaskDetailsViewController: PhotoTaskPhotoViewDelegate {
    
    func photoViewWasDeleted(_ deletedPhotoView: PhotoTaskPhotoView) {
        print("PhotoTaskDetailsViewController: PhotoView was deleted: \(deletedPhotoView)")
        photosScrollView.setContentOffset(CGPoint.zero, animated: false)
        deletedPhotoView.isDeleted = true
        setAutoLayoutConstraints()
    }
}
