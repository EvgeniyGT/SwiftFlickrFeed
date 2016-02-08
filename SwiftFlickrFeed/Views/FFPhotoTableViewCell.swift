
//
//  FFPhotoTableViewCell.swift
//  SwiftFlickrFeed
//
//  Created by Evgeniy Gurtovoy on 1/5/16.
//  Copyright © 2016 Alterplay. All rights reserved.
//

import Foundation
import UIKit

class FFPhotoTableViewCell: UITableViewCell, FFCellProtocol {
    
    // MARK: - Variables
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var photoTitleLabel: UILabel!
    
    override func prepareForReuse() {
        photoImageView.image = nil
        super.prepareForReuse()
    }
}