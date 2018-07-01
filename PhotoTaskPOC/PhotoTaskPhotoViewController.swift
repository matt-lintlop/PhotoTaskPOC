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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        print("Close Photo Button pressed")
    }

}
