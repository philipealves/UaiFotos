//
//  MessageTableViewCell.swift
//  Uai Fotos
//
//  Created by Danillo on 14/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import SwiftyAvatar

class MessageTableViewCell: UITableViewCell {

    static let identifier = "messageTableViewCell"
    
    @IBOutlet weak var friendAvatar: SwiftyAvatar!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
