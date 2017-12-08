//
//  TabBarSwitchExtension.swift
//  Uai Fotos
//
//  Created by ALOC SP05816 on 08/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation
import UIKit

@objc protocol TabBarSwitcher {
    func handleSwipe(sender:UISwipeGestureRecognizer)
}

extension TabBarSwitcher where Self: UIViewController {
    
    func initSwipe(_ direction: UISwipeGestureRecognizerDirection, selector: Selector){
        let swipe = UISwipeGestureRecognizer(target: self, action: selector)
        swipe.direction = direction
        self.view.addGestureRecognizer(swipe)
    }
    
}
