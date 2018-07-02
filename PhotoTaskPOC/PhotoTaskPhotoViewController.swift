//
//  PhotoTaskPhotoViewController.swift
//  Pegasus
//
//  Created by Matt Lintlop on 7/1/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

protocol PhotoTaskPhotoViewDelegate: AnyObject {
    func photoViewWasDeleted(_ deletedPhotoView: PhotoTaskPhotoView)
}

class PhotoTaskPhotoViewController: UIViewController {
    
    @IBOutlet weak var photoView: PhotoTaskPhotoView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    weak var delegate: PhotoTaskPhotoViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        delegate?.photoViewWasDeleted(photoView)
    }

}
