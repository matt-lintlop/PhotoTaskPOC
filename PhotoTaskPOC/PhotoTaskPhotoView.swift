//
//  PhotoTaskView.swift
//  Pegasus
//
//  Created by Matthew Lintlop on 6/18/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

protocol PhotoTaskPhotoViewDelegate: AnyObject {
    func photoViewWasDeleted(_ deletedPhotoView: PhotoTaskPhotoView)
}

class PhotoTaskPhotoView : UIViewFromNib {
    @IBOutlet weak var photoView: PhotoTaskPhotoView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override var nibName: String { return "PhotoTaskPhotoView" }
    weak var delegate: PhotoTaskPhotoViewDelegate?
    
    @IBAction func closePhotoViewButtonPressed(_ sender: Any) {
        delegate?.photoViewWasDeleted(self)
        print("Close Photo Button pressed")
    }
    @IBAction func closePhotoButtonPressedOutside(_ sender: Any) {
        print("Close Photo Button pressed")
   }
 }
