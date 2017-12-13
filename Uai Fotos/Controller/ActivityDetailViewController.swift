//
//  ActivityDetailViewController.swift
//  Uai Fotos
//
//  Created by ALOC SP05816 on 12/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {
    
    var activityDetail: (photo: PhotoDTO, friend: UserDTO)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let feedPhotoView = Bundle.main.loadNibNamed("FeedPhotoCell", owner: self, options: nil)?.first as! FeedPhotoTableViewCell
        
        // Fill data on view
        if let feedItem = self.activityDetail {
            feedPhotoView.userName.text = feedItem.friend.name
            feedPhotoView.userTitle.text = feedItem.friend.title
            feedPhotoView.photoDescription.attributedText = NSMutableAttributedString().bold("\(feedItem.friend.name!): ").normal(feedItem.photo.description ?? "")
            feedPhotoView.photoCaption.text = feedItem.photo.photoCaption
            
            feedPhotoView.photo.kf.indicatorType = .activity
            feedPhotoView.photo.kf.setImage(with: feedItem.photo.imageUrl)
            feedPhotoView.photo.isHeroEnabled = true
            feedPhotoView.userAvatar.kf.indicatorType = .activity
            feedPhotoView.userAvatar.kf.setImage(with: feedItem.friend.avatarUrl)
            feedPhotoView.userAvatar.isHeroEnabled = true
            feedPhotoView.heartButton.imageView?.image = feedPhotoView.heartButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        }
        
        var scrollView: UIScrollView!
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        scrollView.addSubview(feedPhotoView)
        
        NSLayoutConstraint(item: feedPhotoView, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leadingMargin, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: feedPhotoView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200).isActive = true
        NSLayoutConstraint(item: feedPhotoView, attribute: .top, relatedBy: .equal, toItem: scrollView, attribute: .topMargin, multiplier: 1, constant: 10).isActive = true
        NSLayoutConstraint(item: feedPhotoView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30).isActive = true
        
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height * 1.2)
        self.view.addSubview(scrollView)
        
        self.navigationItem.title = "Foto"
        self.tabBarController?.navigationController?.navigationItem.leftBarButtonItem?.title = "Foto"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
