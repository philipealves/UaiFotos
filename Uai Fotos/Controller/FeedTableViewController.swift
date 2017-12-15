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
import Spring

class FeedTableViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.navigationController?.navigationBar.topItem?.title = "Uai Fotos"
        
        // Cria um botão a esquerda
        let leftButton = UIBarButtonItem(image: #imageLiteral(resourceName: "compact_camera"), style: .plain, target: nil, action: nil)
        self.tabBarController?.navigationItem.leftBarButtonItem = leftButton
        
        // Cria um botão a direita
        let rightButton = UIBarButtonItem(image: #imageLiteral(resourceName: "rocket"), style: .plain, target: self, action: #selector(self.segueToMessage))
        self.tabBarController?.navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func segueToMessage() {
        self.performSegue(withIdentifier: "showMessage", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let attributes = [NSAttributedStringKey.foregroundColor: primaryDarkColor,
                          NSAttributedStringKey.font: UIFont(name: "MuralScript", size: 36)]
        
        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = attributes
    }
    
    func loadDataStore() {
        // carrega a lista de fotos do serviço
        self.feedData = UaiFotosDataStore().feedPhotos
        self.tableView.reloadData()
        // reaload na collectionview de amigos
        if let avatarListTableViewCell = self.tableView.tableHeaderView as? AvatarListTableViewCell {
            avatarListTableViewCell.avatarCollection.reloadData()
        }
    }
    
    func likePhoto(_ feedPhotoCell: FeedPhotoTableViewCell, _ indexPah: IndexPath?) {
        guard let row = indexPah?.row else { return }
        guard let _ = self.feedData?[row] else { return }
        if self.feedData![row].photo.liked {
            self.feedData?[row].photo.likes -= 1
            self.feedData?[row].photo.liked = false
        } else {
            self.feedData?[row].photo.likes += 1
            self.feedData?[row].photo.liked = true
        }
        feedPhotoCell.photoCaption.text = self.feedData?[row].photo.photoCaption
        self.loadHeartImageButton((self.feedData?[row])!, feedPhotoCell)
    }
    
    func commentPhoto( _ indexPath: IndexPath?)  {
        performSegue(withIdentifier: "segueComments", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? CommentViewController {
            let indexPath = sender as? IndexPath
            let photo = self.feedData![(indexPath?.row)!].photo
            let friend = self.feedData![(indexPath?.row)!].friend
            dest.photoSelected = photo
            dest.friendSelected = friend
        }
    }

    func favoritePhoto(_ feedPhotoCell: FeedPhotoTableViewCell, _ indexPath: IndexPath?) {
        guard let row = indexPath?.row else { return }
        guard let _ = self.feedData?[row] else { return }
        if self.feedData![row].photo.favorited {
            self.feedData?[row].photo.favorited = false
        } else {
            self.feedData?[row].photo.favorited = true
        }
        self.loadFavoriteImageButton((self.feedData?[row])!, feedPhotoCell)
    }
    
}

extension FeedTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedPhotoTableViewCell.identifier, for: indexPath) as! FeedPhotoTableViewCell
        cell.indexPath = indexPath
        cell.delegate = self
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
            cell.heartButton.imageView?.image = cell.heartButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            self.loadHeartImageButton(feedItem, cell)
            cell.favoriteButton.imageView?.image = cell.favoriteButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
            self.loadFavoriteImageButton(feedItem, cell)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        TipInCellAnimator.fadeIn(cell: cell.contentView)
    }
    
    func loadHeartImageButton(_ feedItem: (photo: PhotoDTO, friend: UserDTO), _ cell: FeedPhotoTableViewCell)  {
        if feedItem.photo.liked {
            cell.heartButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            cell.heartButton.imageView?.tintColor = UIColor.red
            cell.heartButton.animation = Spring.AnimationPreset.Pop.rawValue
            cell.heartButton.animate()
        } else {
            cell.heartButton.animation = Spring.AnimationPreset.ZoomOut.rawValue
            cell.heartButton.animateNext(completion: {
                cell.heartButton.imageView?.image = #imageLiteral(resourceName: "heart-outline")
                cell.heartButton.imageView?.tintColor = UIColor.black
                cell.heartButton.animation = Spring.AnimationPreset.FadeIn.rawValue
                cell.heartButton.animate()
            })
            
        }
        cell.heartButton.setImage(cell.heartButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
    }
    
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

extension FeedTableViewController: FeedPhotoTableViewCellDelegate {
    func feedPhotoCell(_ feedPhotoCell: FeedPhotoTableViewCell, clickRowAt indexPah: IndexPath?) {
        self.likePhoto(feedPhotoCell, indexPah)
    }
    
    func feedPhotoCell(_ feedPhotoCell: FeedPhotoTableViewCell, sharePhotoAt indexPah: IndexPath?) {
        guard let _ = self.feedData?[indexPah?.row ?? -1] else { return }
        if let _ = self.feedData?[indexPah?.row ?? -1] {
            let activityController = UIActivityViewController(activityItems: ["Imagem legal do Uai Fotos", feedPhotoCell.photo.image ?? #imageLiteral(resourceName: "image-placeholder")], applicationActivities: nil)
            activityController.popoverPresentationController?.sourceView = feedPhotoCell.imageView
            self.present(activityController, animated: true, completion: nil)
        }
    }
    
    func feedPhotoCell(_ feedPhotoCell: FeedPhotoTableViewCell, likePhotoAt indexPah: IndexPath?) {
        self.likePhoto(feedPhotoCell, indexPah)
    }
    
    func feedPhotoCell(_ feedPhotoCell: FeedPhotoTableViewCell, commentPhotoAt indexPah: IndexPath?) {
        self.commentPhoto(indexPah)
    }
    
    func feedPhotoCell(_ feedPhotoCell: FeedPhotoTableViewCell, favoritePhotoAt indexPah: IndexPath?) {
        self.favoritePhoto(feedPhotoCell, indexPah!)
    }
    
    func feedPhotoCell(_ feedPhotocell: FeedPhotoTableViewCell, avatarAndTitleTapAt indexPah: IndexPath?) {
        if let (_, friend) = self.feedData?[indexPah?.row ?? -1] {
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let destinationVC = storyboard.instantiateInitialViewController() as! ProfileViewController
            var destinationDS = destinationVC.router!.dataStore!
            destinationDS.user = friend
            self.show(destinationVC, sender: nil)
        }
    }
}
