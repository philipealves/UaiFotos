//
//  CommentViewController.swift
//  Uai Fotos
//
//  Created by Daniel Garcia on 13/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import SwiftyAvatar
import IQKeyboardManagerSwift

class CommentViewController: UIViewController {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendCommentButton: UIButton!
    @IBOutlet weak var userAvatar: SwiftyAvatar!
    @IBOutlet weak var comentTxt: UITextField!
    
    var photoSelected: PhotoDTO! = nil
    var friendSelected: UserDTO! = nil
    let user = UaiFotosDataStore.user
    
    let attributesName = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 17)!,NSAttributedStringKey.foregroundColor: UIColor.black]
    let attributesComment = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue", size: 14)!,NSAttributedStringKey.foregroundColor: UIColor.black]

     let attributesDescription = [NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Bold", size: 14)!,NSAttributedStringKey.foregroundColor: UIColor.darkText]
    
    
    var feedData: [(photo: PhotoDTO, friend: UserDTO)]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: CommentTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 40 // Tamanho aproximado da célula
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        sendCommentButton.imageView?.image = sendCommentButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        sendCommentButton.imageView?.tintColor = primaryColor
        
        comentTxt?.contentMode = .scaleAspectFit
        comentTxt?.clipsToBounds = true
        comentTxt!.layer.cornerRadius = 15
        
        self.userAvatar.kf.indicatorType = .activity
        self.userAvatar.kf.setImage(with: user?.avatarUrl)
        self.userAvatar.isHeroEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(openKeyboard(notification:)), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(closeKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)

    }
    
    @objc func openKeyboard(notification: NSNotification) {
        bottomConstraint.constant = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size.height ?? 0
        view.layoutIfNeeded()
    }
    
    @objc func closeKeyboard() {
        bottomConstraint.constant = 0
        view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        IQKeyboardManager.sharedManager().enable = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        IQKeyboardManager.sharedManager().enable = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
  
}


extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photoSelected.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as! CommentTableViewCell
    
        let comment = photoSelected.comments[indexPath.row]
        
        if indexPath.row == 0 {
            cell.avatarUser.kf.indicatorType = .activity
            cell.avatarUser.kf.setImage(with: friendSelected.avatarUrl)
            cell.avatarUser.isHeroEnabled = true
            let name = friendSelected.name! + " "
            let nameAttributedString = NSMutableAttributedString(string: name, attributes: attributesName)
            let commentAttributedString = NSAttributedString(string: photoSelected.description!, attributes: attributesDescription)
            nameAttributedString.append(commentAttributedString)
            cell.commentUser.attributedText = nameAttributedString
        } else {

            cell.avatarUser.kf.indicatorType = .activity
            cell.avatarUser.kf.setImage(with: comment.user.avatarUrl)
            cell.avatarUser.isHeroEnabled = true
            let name = comment.user.name! + " "
            let nameAttributedString = NSMutableAttributedString(string: name, attributes: attributesName)
            let commentAttributedString = NSAttributedString(string: comment.textComment!, attributes: attributesComment)
            nameAttributedString.append(commentAttributedString)
            cell.commentUser.attributedText = nameAttributedString
        }
        
        return cell
        
    }
    
}
