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

protocol FeedPhotoTableViewCellDelegate {
    func feedPhotoCell(_ feedPhotoCell: FeedPhotoTableViewCell, clickRowAt indexPah: IndexPath?)
    func feedPhotoCell(_ feedPhotoCell: FeedPhotoTableViewCell, sharePhotoAt indexPah: IndexPath?)
    func feedPhotoCell(_ feedPhotoCell: FeedPhotoTableViewCell, likePhotoAt indexPah: IndexPath?)
    func feedPhotoCell(_ feedPhotoCell: FeedPhotoTableViewCell, favoritePhotoAt indexPah: IndexPath?)
}

class FeedPhotoTableViewCell: UITableViewCell {
    static let identifier = "feedPhotoTableViewCell"
    @IBOutlet weak var userAvatar: SwiftyAvatar!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var photoCaption: SpringLabel!
    @IBOutlet weak var photoDescription: UILabel!
    @IBOutlet weak var heartButton: SpringButton!
    @IBOutlet weak var favoriteButton: SpringButton!
    @IBOutlet weak var heartImageView: SpringImageView!
    
    var delegate: FeedPhotoTableViewCellDelegate?
    var indexPath: IndexPath?
    
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
        if self.delegate != nil {
            self.delegate?.feedPhotoCell(self, clickRowAt: self.indexPath)
        }
    }
    
    @IBAction func likePhoto(_ sender: Any) {
        if self.delegate != nil {
            self.delegate?.feedPhotoCell(self, likePhotoAt: self.indexPath)
        }
    }
    
    @IBAction func sharePhoto(_ sender: SpringButton) {
        if self.delegate != nil {
            self.delegate?.feedPhotoCell(self, sharePhotoAt: self.indexPath)
            sender.animation = Spring.AnimationPreset.Pop.rawValue
            sender.animate()
        }
    }
    
    @IBAction func favoritePhoto(_ sender: Any) {
        if self.delegate != nil {
            self.delegate?.feedPhotoCell(self, favoritePhotoAt: self.indexPath)
        }
    }
}
