//
//  PhotoGalleryCollectionViewCell.swift
//  Uai Fotos
//
//  Created by João Paulo Scopus on 12/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "photoCollectionViewCell"
    
    @IBOutlet weak var imageGallery: UIImageView!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint?
    public static var horizontalPhotoNumber: Int = 3
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        self.widthConstraint?.constant = PhotoCollectionViewCell.horizontalPhotoNumber == 1 ? screenWidth : (screenWidth / CGFloat(PhotoCollectionViewCell.horizontalPhotoNumber)) - (CGFloat(PhotoCollectionViewCell.horizontalPhotoNumber) - 1.5)
    }
}
