//
//  PhotoTaskViewController.swift
//  PhotoTaskPOC
//
//  Created by Matt Lintlop on 6/16/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

class PhotoTaskViewController: UIViewController {

    @IBOutlet weak var photoTaskNameLabel: UILabel!
    @IBOutlet weak var photoTaskLocationLabel: UILabel!
    @IBOutlet weak var photoTaskDetailsTextField: UITextView!
    
    @IBOutlet weak var storeNotesTextField: UITextView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func submitPhotoTaskPressed(_ sender: Any) {
        print("Submit Photo Task Pressed")
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
