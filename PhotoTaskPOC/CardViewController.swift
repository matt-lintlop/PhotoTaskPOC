//
//  CardViewController.swift
//  PhotoTaskPOC
//
//  Created by Matt Lintlop on 6/28/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation
import UIKit

class CardViewController: UIViewController {
    
    func removeChildViewController() {
        
    }
}

protocol CardViewControllerDelegate {
    func heightForCardHeader(cardViewController: CardViewController) -> CGFloat
}

extension String {
    var localized: String {
        return self
    }
}
