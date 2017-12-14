//
//  FilterPhotoViewController.swift
//  Uai Fotos
//
//  Created by João Paulo Scopus on 14/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit

class FilterPhotoViewController: UIViewController {

    
    @IBOutlet weak var previewImage: UIImageView!
    var imageTaked: UIImage?
    override func viewDidLoad() {        
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        if let image = imageTaked {
            //self.previewImage?.image = UIImage(image: image, scaledTo: CGSize(1.0))
        }
    }

}
