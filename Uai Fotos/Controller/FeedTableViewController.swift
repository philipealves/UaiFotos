//
//  FeedTableViewController.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 07/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import Kingfisher
import Hero
import SwiftRandom
import RxSwift

class FeedTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    var feedData: [(photo: PhotoDTO, friend: UserDTO)]?
    let avatarCollectionData = AvatarCollectionData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "FeedPhotoCell", bundle: nil), forCellReuseIdentifier: FeedPhotoTableViewCell.identifier)
        
        // cabeçalho da tableview com a lista de usuários...
        if let avatarListTableViewCell = Bundle.main.loadNibNamed("AvatarListTableViewCell", owner: self, options: nil)?.first as? AvatarListTableViewCell {
            avatarListTableViewCell.avatarCollection.delegate = self.avatarCollectionData
            avatarListTableViewCell.avatarCollection.dataSource = self.avatarCollectionData
            
            self.tableView.tableHeaderView = avatarListTableViewCell
        }
        
        self.loadDataStore()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDataStore() {
        // carrega a lista de fotos do serviço
        PicsumApi().photoList()
            .subscribe(onNext: {
                UaiFotosDataStore.picsumImageList = $0
                let uaifotosDS = UaiFotosDataStore()
                uaifotosDS.generateFeed(photoNumber: Int.random())
                self.feedData = uaifotosDS.feedPhotos
                self.tableView.reloadData()
                // reaload na collectionview de amigos
                if let avatarListTableViewCell = self.tableView.tableHeaderView as? AvatarListTableViewCell {
                    avatarListTableViewCell.avatarCollection.reloadData()
                }
            },onError: { print($0) }).disposed(by: self.disposeBag)
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedPhotoTableViewCell.identifier, for: indexPath) as! FeedPhotoTableViewCell
        
        // Configure the cell...
        if let feedItem = self.feedData?[indexPath.row] {
            cell.userName.text = feedItem.friend.name
            cell.userTitle.text = feedItem.friend.title
            cell.photoDescription.attributedText = NSMutableAttributedString().bold("\(feedItem.friend.name!): ").normal(feedItem.photo.description ?? "")
            cell.photoCaption.text = feedItem.photo.photoCaption
            
            cell.photo.kf.indicatorType = .activity
            cell.photo.kf.setImage(with: feedItem.photo.imageUrl)
            cell.photo.isHeroEnabled = true
            cell.userAvatar.kf.indicatorType = .activity
            cell.userAvatar.kf.setImage(with: feedItem.friend.avatarUrl)
            cell.userAvatar.isHeroEnabled = true
            
        }
        return cell
    }/*
     
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
     if let avatarListTableViewCell = Bundle.main.loadNibNamed("AvatarListTableViewCell", owner: self, options: nil)?.first as? AvatarListTableViewCell {
     avatarListTableViewCell.avatarCollection.delegate = self.avatarCollectionData
     avatarListTableViewCell.avatarCollection.dataSource = self.avatarCollectionData
     return avatarListTableViewCell
     }
     
     return nil
     }
     */
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
    
}
