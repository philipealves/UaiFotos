//
//  AvatarCollectionViewCell.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 07/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import SwiftyAvatar

class AvatarCollectionViewCell: UICollectionViewCell {
    static let identifier = "avatarCollectionViewCell"
    
    @IBOutlet weak var userAvatar: SwiftyAvatar!
    @IBOutlet weak var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
