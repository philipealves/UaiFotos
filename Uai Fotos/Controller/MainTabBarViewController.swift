//
//  MainTabBarViewController.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 06/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import ChameleonFramework
import Hero

class MainTabBarViewController: UITabBarController, TabBarSwitcher {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = primaryDarkColor
        //self.navigationController?.navigationBar.titleTextAttributes?.append(contrastColor, forKey: NSAttributedStringKey.foregroundColor)
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = primaryColor
        UITabBar.appearance().tintColor = UIColor.white
        
        let attributes = [NSAttributedStringKey.foregroundColor: primaryDarkColor,
                         NSAttributedStringKey.font: UIFont(name: "MuralScript", size: 36)]

        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        // Animation on tab change
        self.heroTabBarAnimationType = .zoom
        
        // Swipe Gesture (Left / Right)
        self.initSwipe(.left, selector: #selector(handleSwipe))
        self.initSwipe(.right, selector: #selector(handleRightSwipe))
    }
    
    // Handle the Swipe Gesture
    @objc func handleSwipe(sender gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if self.selectedIndex < 5 {
                self.selectedIndex += 1
            }
        } else if gesture.direction == .right {
            if self.selectedIndex > 0 {
                self.selectedIndex -= 1
            }
        }
    }
    
    @objc func handleRightSwipe(sender gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .right {
            if self.selectedIndex > 0 {
                self.selectedIndex -= 1
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
