//
//  MessageTableViewController.swift
//  Uai Fotos
//
//  Created by Danillo on 14/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import RxSwift

class MessageTableViewController: UITableViewController {
    
    let disposeBag = DisposeBag()
    var feedData: [UserDTO]?
    var friendSelected: UserDTO?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = 60 // Tamanho aproximado da célula
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.register(UINib(nibName: "MessageTableViewCell", bundle: nil), forCellReuseIdentifier: MessageTableViewCell.identifier)
        feedData = UaiFotosDataStore.user?.friends
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.feedData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.feedData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageTableViewCell.identifier, for: indexPath) as! MessageTableViewCell
        
        // Configure the cell...
        if let feedItem = self.feedData?[indexPath.row] {
            cell.friendAvatar.kf.setImage(with: feedItem.avatarUrl)
            cell.friendName.text = feedItem.name
            cell.friendStatus.text = "Online há 28 minutos"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.friendSelected = self.feedData?[indexPath.row]
        self.performSegue(withIdentifier: "showChat", sender: self)
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let dest = segue.destination as? ChatViewController {
                dest.friend = self.friendSelected
            }
        }
    
}
