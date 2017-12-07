//
//  FeedPhotoTableViewCell.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 07/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import SwiftyAvatar

class FeedPhotoTableViewCell: UITableViewCell {
    static let identifier = "feedPhotoTableViewCell"
    @IBOutlet weak var userAvatar: SwiftyAvatar!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photoCaption: UILabel!
    @IBOutlet weak var photoDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
