

//
//  ROUND]]].swift
//  Uai Fotos
//
//  Created by João Paulo Scopus on 14/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import Spring

@IBDesignable
class RoundButton: SpringButton {

    @IBInspectable var paoQueijoCornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = paoQueijoCornerRadius
        }
    }
    
    @IBInspectable var paoQueijoBorderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = paoQueijoBorderWidth
        }
    }
    @IBInspectable var paoQueijoBorderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = paoQueijoBorderColor.cgColor
        }
    }
}
