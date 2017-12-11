//
//  FeedPhotoTableViewCell.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 07/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import SwiftyAvatar
import Spring

class FeedPhotoTableViewCell: UITableViewCell {
    static let identifier = "feedPhotoTableViewCell"
    @IBOutlet weak var userAvatar: SwiftyAvatar!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photoCaption: UILabel!
    @IBOutlet weak var photoDescription: UILabel!
    @IBOutlet weak var heartImageView: SpringImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapOnImage(_:)))
        self.photo.addGestureRecognizer(tapGestureRecognizer)
        self.heartImageView.alpha = 0
        self.heartImageView.image = self.heartImageView.image?.withRenderingMode(.alwaysTemplate)
        self.heartImageView.tintColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func handleTapOnImage(_ : UITapGestureRecognizer)  {
        self.heartImageView.animation = Spring.AnimationPreset.FadeIn.rawValue
        self.heartImageView.animate()
        self.heartImageView.animation = Spring.AnimationPreset.ZoomOut.rawValue
        self.heartImageView.duration = 2.0
        self.heartImageView.curve = Spring.AnimationCurve.EaseOut.rawValue
        self.heartImageView.animateTo()
    }
}
