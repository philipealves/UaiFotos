//
//  ActivityTableViewController.swift
//  Uai Fotos
//
//  Created by ALOC SP05816 on 07/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import RxSwift

class ActivityTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    var feedData: [(photo: PhotoDTO, friend: UserDTO)]?
    var followersFeedData: [(photo: PhotoDTO, friend: UserDTO)]?
    var selected: (photo: PhotoDTO, friend: UserDTO)?
    var isFollowing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.estimatedRowHeight = 60 // Tamanho aproximado da célula
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.tableView.register(UINib(nibName: "ActivityTableViewCell", bundle: nil), forCellReuseIdentifier: ActivityTableViewCell.identifier)
        self.tableView.register(UINib(nibName: "FeedPhotoTableViewCell", bundle: nil), forCellReuseIdentifier: FeedPhotoTableViewCell.identifier)
        
        self.loadDataStore()
        self.loadFollowersDataStore()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedData?.count ?? 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Limpa o valor do título
        self.tabBarController?.navigationItem.title = ""
        
        // Cria um botão a esquerda
        let leftButton = UIBarButtonItem(title: "Seguindo", style: .done, target: self, action: #selector(leftButton(sender:)))
        self.tabBarController?.navigationItem.leftBarButtonItem = leftButton
        
        self.tabBarController?.navigationItem.setLeftBarButton(leftButton, animated: false)
        
        // Cria um botão a direita
        let rightButton = UIBarButtonItem(title: "Você", style: .done, target: self, action: #selector(rightButton(sender:)))
        self.tabBarController?.navigationItem.rightBarButtonItem = rightButton
        
        self.tabBarController?.navigationItem.setRightBarButton(rightButton, animated: false)
        
        self.rightTitleBorder(withNavigationBar: (self.navigationController?.navigationBar)!)
    }
    
    @objc func leftButton(sender: UIBarButtonItem) {
        self.navigationController?.navigationBar.borderColor = UIColor.black
        if let navigationController = self.navigationController {
            let navigationBar = navigationController.navigationBar
            self.leftTitleBorder(withNavigationBar: navigationBar)
            isFollowing = true
            self.tableView.reloadData()
        }
    }
    
    @objc func rightButton(sender: UIBarButtonItem) {
        if let navigationController = self.navigationController {
            let navigationBar = navigationController.navigationBar
            self.rightTitleBorder(withNavigationBar: navigationBar)
            isFollowing = false
            self.tableView.reloadData()
        }
    }
    
    func leftTitleBorder(withNavigationBar navigationBar: UINavigationBar) {
        let navBorder: UIView = UIView(frame: CGRect(x: 0, y: navigationBar.frame.size.height-1, width: navigationBar.frame.size.width/2, height: 1))
        
        self.navigationController?.navigationBar.removeAllSubviews()
        
        navBorder.backgroundColor = UIColor(red: 0.19, green: 0.19, blue: 0.2, alpha: 1)
        navBorder.isOpaque = true
        self.navigationController?.navigationBar.addSubview(navBorder)
    }
    
    func rightTitleBorder(withNavigationBar navigationBar: UINavigationBar) {
        let navBorder: UIView = UIView(frame: CGRect(x: navigationBar.frame.size.width/2, y: navigationBar.frame.size.height-1, width: navigationBar.frame.size.width/2, height: 1))
        
        self.navigationController?.navigationBar.removeAllSubviews()
        
        navBorder.backgroundColor = UIColor(red: 0.19, green: 0.19, blue: 0.2, alpha: 1)
        navBorder.isOpaque = true
        self.navigationController?.navigationBar.addSubview(navBorder)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.removeAllSubviews()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivityTableViewCell.identifier, for: indexPath) as! ActivityTableViewCell
        
        let feed = isFollowing ? self.followersFeedData : feedData
        
        // Configure the cell...
        if let feedItem = feed?[indexPath.row] {
            cell.contentText.text = feedItem.photo.description
            
            cell.photo.kf.indicatorType = .activity
            cell.photo.kf.setImage(with: feedItem.photo.imageUrl)
            cell.photo.isHeroEnabled = true
            
            cell.userAvatar.kf.indicatorType = .activity
            cell.userAvatar.kf.setImage(with: feedItem.friend.avatarUrl)
            cell.userAvatar.isHeroEnabled = true
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selected = self.feedData![indexPath.row]
        self.tableView.deselectRow(at: indexPath, animated: false)
        self.performSegue(withIdentifier: "activityDetailSegue", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ActivityDetailTableViewController {
            dest.activityDetail = self.selected
        }
    }
    
    func loadDataStore() {
        // carrega a lista de fotos do serviço
        self.feedData = UaiFotosDataStore().feedPhotos
        self.tableView.reloadData()
    }
    
    func loadFollowersDataStore() {
        // carrega a lista de fotos do serviço
        self.followersFeedData = UaiFotosDataStore().feedPhotos
        self.tableView.reloadData()
    }

}
