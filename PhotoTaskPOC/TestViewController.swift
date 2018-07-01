//
//  TestViewController.swift
//  TestApp
//
//  Created by Matt Lintlop on 7/1/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoView: PhotoTaskPhotoView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = "Hello"
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        print("Close Photo Button pressed")
    }

}
