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
    
 //   @IBOutlet weak var photosStackView: UIStackView!
    @IBOutlet weak var lowerSectionView: UIView!
    @IBOutlet weak var submitPhotoTaskButton: UIButton!
 //   @IBOutlet weak var photosStackViewContentWidthConstraint: NSLayoutConstraint!
//    @IBOutlet weak var photosScrollView: UIScrollView!
    @IBOutlet weak var addPhotoButton: UIButton!
 //   @IBOutlet weak var scrollViewContentView: UIView!
    @IBOutlet weak var stackviewPlaceholderView: UIView!
    var photosScrollView: UIScrollView!
    var photosStackView: UIStackView!
    
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
        photosScrollView = UIScrollView()
        photosScrollView.translatesAutoresizingMaskIntoConstraints = false
        stackviewPlaceholderView.addSubview(photosScrollView)
        stackviewPlaceholderView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[photosScrollView]|", options: .alignAllCenterX, metrics: nil, views: ["photosScrollView": photosScrollView]))
        stackviewPlaceholderView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[photosScrollView]|", options: .alignAllCenterX, metrics: nil, views: ["photosScrollView": photosScrollView]))
        
        photosStackView = UIStackView()
        photosStackView.translatesAutoresizingMaskIntoConstraints = false
        photosStackView.axis = .horizontal
        photosStackView.spacing = 10
        photosScrollView.addSubview(photosStackView)
        photosScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[photosStackView]|", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: ["photosStackView": photosStackView]))
        photosScrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[photosStackView]", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: ["photosStackView": photosStackView]))
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
        let height:CGFloat = 80.0
        
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
        let duration = 0.25
        UIView.animate(withDuration: duration, animations: {
            deletedPhotoView.alpha = 0.0
            deletedPhotoView.isDeleted = true
        }) { (finished) in
            self.photosStackView.layoutIfNeeded()
        }
    }
}
