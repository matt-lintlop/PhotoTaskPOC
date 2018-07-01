//
//  PhotoTaskView.swift
//  Pegasus
//
//  Created by Matthew Lintlop on 6/18/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class PhotoTaskPhotoView : UIViewFromNib {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    override var nibName: String { return "PhotoTaskPhotoView" }
    
    @IBAction func closePhotoViewButtonPressed(_ sender: Any) {
        print("Close Photo Button pressed")
    }
    @IBAction func closePhotoButtonPressedOutside(_ sender: Any) {
        print("Close Photo Button pressed")
   }
    
    
    
    
}
