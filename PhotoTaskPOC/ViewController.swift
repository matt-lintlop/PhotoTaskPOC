//
//  ViewController.swift
//  PhotoTaskPOC
//
//  Created by Matt Lintlop on 6/16/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func buttonPressed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Testing", bundle: nil)
        let testVC = storyboard.instantiateViewController(withIdentifier: "TestingViewController")
        let view = testVC.view
        print(testVC)
        present(testVC, animated: true, completion: nil)
        //        print(view ?? "no view")
    }
    
}

