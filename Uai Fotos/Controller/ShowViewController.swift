//
//  ShowViewController.swift
//  Uai Fotos
//
//  Created by Leandro Jabur on 12/13/17.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKShareKit

class ShowViewController: UIViewController {

    
    var index = 0
    var imagesArr = [UIImage]()
    var dict : [String : AnyObject]!
    let animationDuration: TimeInterval = 0.25
    let switchingInterval: TimeInterval = 3
    static let imagesNames = ["Abertura-1","Abertura-2","Abertura-3","Abertura-4"]
    
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var imgShow: UIImageView!
    
    @IBOutlet weak var btnFacebook: UIButton!
    
    @IBAction func btnLogin(_ sender: UIButton) {
        performSegue(withIdentifier: "segueLogin", sender: nil)
    }
    
    @IBAction func btnEntrarEmail(_ sender: UIButton) {
        performSegue(withIdentifier: "segueLogin", sender: nil)
    }
    
    @IBAction func btnFacebook(_ sender: UIButton) {
        loginFacebook()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblTitle.font = UIFont(name: "MuralScript", size: 90)
        
        fillImages()
        imgShow.image = imagesArr[1]
        animateImageView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loginFacebook(){
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if (error == nil){
                let fbloginresult : FBSDKLoginManagerLoginResult = result!
                if fbloginresult.grantedPermissions != nil {
                    if(fbloginresult.grantedPermissions.contains("email"))
                    {
                        self.getFBUserData()
                        fbLoginManager.logOut()
                        self.performSegueMain()
                    }
                }
            }
        }
    }
    
    func getFBUserData(){
        if((FBSDKAccessToken.current()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    self.dict = result as! [String : AnyObject]
                    print(result!)
                    print(self.dict)
                }
            })
        }
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
    
    private func performSegueMain(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()!
        
        UIApplication.shared.delegate?.window??.rootViewController = controller
        UIApplication.shared.delegate?.window??.makeKeyAndVisible()
    }

}
