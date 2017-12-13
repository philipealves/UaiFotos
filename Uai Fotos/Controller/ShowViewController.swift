//
//  ShowViewController.swift
//  Uai Fotos
//
//  Created by Leandro Jabur on 12/13/17.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit

class ShowViewController: UIViewController {

    @IBOutlet weak var imgShow: UIImageView!
    
    
    var index = 0
    var imagesArr = [UIImage]()
    let animationDuration: TimeInterval = 0.25
    let switchingInterval: TimeInterval = 3
    static let imagesNames = ["Abertura-1","Abertura-2","Abertura-3","Abertura-4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillImages()
        imgShow.image = imagesArr[1]
        animateImageView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func fillImages(){
        for i in 0..<(ShowViewController.imagesNames.count) {
            imagesArr.append(UIImage(named: ShowViewController.imagesNames[i])!)
        }
    }
    
    func animateImageView()
    {
        CATransaction.begin()
        
        CATransaction.setAnimationDuration(animationDuration)
        CATransaction.setCompletionBlock {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.switchingInterval) {
                self.animateImageView()
            }
        }
        
        let transition = CATransition()
        //transition.type = kCATransitionFade
        
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        
        imgShow.layer.add(transition, forKey: kCATransition)
        imgShow.image = imagesArr[index]
        
        CATransaction.commit()
        
        index = index < imagesArr.count - 1 ? index + 1 : 0
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
