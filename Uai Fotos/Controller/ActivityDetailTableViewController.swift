//
//  ActivityDetailTableViewController.swift
//  Uai Fotos
//
//  Created by ALOC SP05816 on 14/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import Spring

class ActivityDetailTableViewController: UITableViewController {

    var activityDetail: (photo: PhotoDTO, friend: UserDTO)?
    
    var feedPhotoView: FeedPhotoTableViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "FeedPhotoCell", bundle: nil), forCellReuseIdentifier: FeedPhotoTableViewCell.identifier)
        
        feedPhotoView = Bundle.main.loadNibNamed("FeedPhotoCell", owner: self, options: nil)?.first as! FeedPhotoTableViewCell
        
        self.navigationItem.title = "Foto"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // Configure the cell...
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
            self.loadFavoriteImageButton(feedItem, feedPhotoView)
        }

        return feedPhotoView
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func loadFavoriteImageButton(_ feedItem: (photo: PhotoDTO, friend: UserDTO), _ cell: FeedPhotoTableViewCell)  {
        if feedItem.photo.favorited {
            cell.favoriteButton.setImage(#imageLiteral(resourceName: "bookmark"), for: .normal)
            cell.favoriteButton.imageView?.tintColor = UIColor.black
            cell.favoriteButton.animation = Spring.AnimationPreset.Pop.rawValue
            cell.favoriteButton.animate()
        } else {
            cell.favoriteButton.animation = Spring.AnimationPreset.ZoomOut.rawValue
            cell.favoriteButton.animateNext(completion: {
                cell.favoriteButton.setImage(#imageLiteral(resourceName: "bookmark-outline"), for: .normal)
                cell.favoriteButton.imageView?.tintColor = UIColor.black
                cell.favoriteButton.animation = Spring.AnimationPreset.FadeIn.rawValue
                cell.favoriteButton.animate()
            })
            
        }
        cell.favoriteButton.setImage(cell.favoriteButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
    }

}
