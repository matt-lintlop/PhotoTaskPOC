//
//  PhotoTaskView.swift
//  Pegasus
//
//  Created by Matthew Lintlop on 6/18/18.
//  Copyright © 2018 Apple Inc. All rights reserved.
//

import UIKit

protocol PhotoTaskPhotoViewDelegate: AnyObject {
    func photoViewWasDeleted(_ deletedPhotoView: PhotoTaskPhotoView)
}

class PhotoTaskPhotoView : UIView {
    
    weak var deletePhotoButton: UIButton?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
 }
