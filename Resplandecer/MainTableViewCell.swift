//
//  MainScreenContentController.swift
//  RadioResplandecer
//
//  Created by Benito Sanchez on 1/12/21.
//  Copyright © 2021 Radio Resplandecer. All rights reserved.
//

import Foundation
import UIKit

class MainTableViewCell: UITableViewCell {
    
    @IBOutlet var titleViewCell: UILabel!
    @IBOutlet var contentViewCell: UILabel!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        titleViewCell.numberOfLines = 0
        contentViewCell.numberOfLines = 0

    }
}
