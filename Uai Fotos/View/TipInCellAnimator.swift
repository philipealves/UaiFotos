//
//  TipInCellAnimator.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 14/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit

import QuartzCore

let TipInCellAnimatorStartTransform:CATransform3D = {
    let rotationDegrees: CGFloat = -15.0
    let rotationRadians: CGFloat = rotationDegrees * (CGFloat(Double.pi)/180.0)
    let offset = CGPoint(x: -20, y: -20)
    var startTransform = CATransform3DIdentity
    startTransform = CATransform3DRotate(CATransform3DIdentity,
                                         rotationRadians, 0.0, 0.0, 1.0)
    startTransform = CATransform3DTranslate(startTransform, offset.x, offset.y, 0.0)
    
    return startTransform
}()

class TipInCellAnimator {
    // placeholder for things to come -- only fades in for now
    class func fadeIn(cell: UIView) {
        let view = cell
        view.layer.opacity = 0.1
        UIView.animate(withDuration: 1.4) {
            view.layer.opacity = 1
        }
    }
    
    class func fancyRotation(cell: UIView) {
        let view = cell
        
        view.layer.transform = TipInCellAnimatorStartTransform
        view.layer.opacity = 0.8
        
        UIView.animate(withDuration: 0.4) {
            view.layer.transform = CATransform3DIdentity
            view.layer.opacity = 1
        }
    }
    
    class func zoomIn(view: UIView) {
        UIView.animate(withDuration: 1.0) {
            view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
}
