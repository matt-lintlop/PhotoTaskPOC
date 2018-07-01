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

class PhotoTaskPhotoView : UIView {
    @IBOutlet weak var photoView: PhotoTaskPhotoView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    weak var delegate: PhotoTaskPhotoViewDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func closePhotoViewButtonPressed(_ sender: Any) {
        delegate?.photoViewWasDeleted(self)
        print("Close Photo Button pressed: delegate = \(delegate)")
    }
    @IBAction func closePhotoButtonPressedOutside(_ sender: Any) {
        print("Close Photo Button pressed")
   }
 }
