//
//  PhotoGalleryViewController.swift
//  Uai Fotos
//
//  Created by João Paulo Scopus on 12/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import SwiftMessages
import Photos
import BFKit

class PhotoGalleryViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photosCollectionView: UICollectionView!

    
    lazy var imageLibary = [PHAsset]()
    var widthCell = CGFloat(0.0)
    var heightCell = CGFloat(0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photosCollectionView.delegate = self
        self.photosCollectionView.dataSource = self
        settingSizeCellCollection()
    }

    func settingSizeCellCollection(){
        widthCell = (UIScreen.main.bounds.size.width / 4) - 2.5
        heightCell = ((UIScreen.main.bounds.size.height * 0.5) / 3) - 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getImagemOfLibary()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getImagemOfLibary(){
        let assets = PHAsset.fetchAssets(with: PHAssetMediaType.unknown, options: nil)
        assets.enumerateObjects({ (object, count, stop) in
            self.imageLibary.append(object)
        })
        self.imageLibary.reverse()
        self.selectedFirstPhotoInCollection()
        self.photosCollectionView.reloadData()
        
    }
    func selectedFirstPhotoInCollection(){
        if let firstObject = self.imageLibary.first {
            PHImageManager.default().requestImage(for: firstObject,
                                                  targetSize: (self.imageView.image?.size)!,
                                                  contentMode: .aspectFill,
                                                  options: nil){ (result, _ ) in
                self.imageView.image = result
            }
        }
    }
}

extension PhotoGalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageLibary.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = self.photosCollectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        let photoItem = self.imageLibary[indexPath.row]
        let manager = PHImageManager.default()
        if cell.tag != 0{
            manager.cancelImageRequest(PHImageRequestID(cell.tag))
        }
        let size = CGSize(width: widthCell, height: heightCell)
        
        cell.tag = Int(manager.requestImage(for: photoItem, targetSize: size, contentMode: .aspectFill, options: nil) { (result, _ ) in
            cell.imageGallery?.image = result
        })
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthCell, height: heightCell)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
}



