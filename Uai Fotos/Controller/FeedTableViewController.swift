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
import Spring

class FeedTableViewController: UIViewController {
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
    
    override func viewWillAppear(_ animated: Bool) {
        // Limpa o valor do título
        self.tabBarController?.navigationItem.title = "Uai Fotos"
        
        let attributes = [NSAttributedStringKey.foregroundColor: primaryDarkColor,
                          NSAttributedStringKey.font: UIFont(name: "MuralScript", size: 36)]
        
        self.tabBarController?.navigationController?.navigationBar.titleTextAttributes = attributes
        
        // Cria um botão a esquerda
        let leftButton = UIBarButtonItem(image: #imageLiteral(resourceName: "compact_camera"), style: .plain, target: nil, action: nil)
        self.tabBarController?.navigationItem.leftBarButtonItem = leftButton
        
        // Cria um botão a direita
        let rightButton = UIBarButtonItem(image: #imageLiteral(resourceName: "rocket"), style: .plain, target: nil, action: nil)
        self.tabBarController?.navigationItem.rightBarButtonItem = rightButton
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

    func likePhoto(_ feedPhotoCell: FeedPhotoTableViewCell, _ indexPah: IndexPath?) {
        guard let row = indexPah?.row else { return }
        guard let _ = self.feedData?[row] else { return }
        self.feedData?[row].photo.likes += 1
        self.feedData?[row].photo.liked = true
        feedPhotoCell.photoCaption.text = self.feedData?[row].photo.photoCaption
        self.loadHeartImageButton((self.feedData?[row])!, feedPhotoCell)
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
            
        }
        return cell
    }
    
    func loadHeartImageButton(_ feedItem: (photo: PhotoDTO, friend: UserDTO), _ cell: FeedPhotoTableViewCell)  {
        if feedItem.photo.liked {
            cell.heartButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            cell.heartButton.imageView?.tintColor = UIColor.red
        } else {
            cell.heartButton.imageView?.image = #imageLiteral(resourceName: "heart-outline")
            cell.heartButton.imageView?.tintColor = UIColor.black
            
        }
        cell.heartButton.setImage(cell.heartButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        cell.heartButton.animation = Spring.AnimationPreset.Pop.rawValue
        cell.heartButton.animate()
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
    
}
