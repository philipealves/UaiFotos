//
//  CommentViewController.swift
//  Uai Fotos
//
//  Created by Daniel Garcia on 13/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import SwiftyAvatar
import RxSwift

class CommentViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendCommentButton: UIButton!
    @IBOutlet weak var userAvatar: SwiftyAvatar!
    @IBOutlet weak var comentTxt: UITextField!
    
    
    
    var feedData: [(photo: PhotoDTO, friend: UserDTO)]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDataStore()
        self.tableView.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: CommentTableViewCell.identifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 40 // Tamanho aproximado da célula
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        sendCommentButton.imageView?.image = sendCommentButton.imageView?.image?.withRenderingMode(.alwaysTemplate)
        sendCommentButton.imageView?.tintColor = primaryColor
        
        let user = UaiFotosDataStore.user
        self.userAvatar.kf.indicatorType = .activity
        self.userAvatar.kf.setImage(with: user?.avatarUrl)
        self.userAvatar.isHeroEnabled = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    
}


extension CommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableViewCell.identifier, for: indexPath) as! CommentTableViewCell
        
        let feedItem = self.feedData?[indexPath.row]
        
        cell.avatarUser.kf.indicatorType = .activity
        cell.avatarUser.kf.setImage(with: feedItem?.photo.imageUrl)
        cell.avatarUser.isHeroEnabled = true
        
        
        
        return cell
        
    }
    
}
