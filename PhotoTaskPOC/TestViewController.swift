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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
