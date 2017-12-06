//
//  ColorTabBarItem.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 06/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit

class ColorTabBarItem: UITabBarItem {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let myImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = myImage
    }
}
