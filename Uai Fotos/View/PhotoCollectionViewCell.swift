//
//  PhotoGalleryCollectionViewCell.swift
//  Uai Fotos
//
//  Created by João Paulo Scopus on 12/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageGallery: UIImageView!
    
    @IBOutlet weak var widthConstraint: NSLayoutConstraint?
    @IBInspectable var horizontalPhotoNumber: Int = 3
    @IBInspectable var horizontalMarginNumber: Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        self.widthConstraint?.constant = (screenWidth / CGFloat(horizontalPhotoNumber)) - CGFloat(horizontalMarginNumber)
    }
}
