//
//  CommentTableViewCell.swift
//  Uai Fotos
//
//  Created by Daniel Garcia on 13/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import SwiftyAvatar

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var commentUser: UILabel!
    @IBOutlet weak var avatarUser: SwiftyAvatar!
    static let identifier = "commentTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
