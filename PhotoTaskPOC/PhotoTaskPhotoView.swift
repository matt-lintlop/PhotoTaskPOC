//
//  PhotoTaskView.swift
//  Pegasus
//
//  Created by Matthew Lintlop on 6/18/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

class PhotoTaskPhotoView : UIView {
    
    var isDeleted: Bool {
        didSet {
            isHidden = isDeleted
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        isDeleted = false
        super.init(coder: aDecoder)
    }
 }
