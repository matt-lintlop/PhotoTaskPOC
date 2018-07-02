//
//  PhotoTaskPhotoViewController.swift
//  Pegasus
//
//  Created by Matt Lintlop on 7/1/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class PhotoTaskPhotoViewController: UIViewController {
    
    @IBOutlet weak var photoView: PhotoTaskPhotoView!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var deletePhotoButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        print("PhotoTaskPhotoViewController: Close Photo Button pressed")
    }

}
