//
//  ActivityCell.swift
//  Uai Fotos
//
//  Created by ALOC SP05816 on 07/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import SwiftyAvatar
import Spring

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var userAvatar: SwiftyAvatar!
    
    @IBOutlet weak var contentText: UILabel!
    
    @IBOutlet weak var actionButton: DesignableButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
