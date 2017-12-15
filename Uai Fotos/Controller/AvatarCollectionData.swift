//
//  AvatarCollectionView.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 07/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit

class AvatarCollectionData: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var friends: [UserDTO]?
    
    func reloadData()  {
        self.friends = UaiFotosDataStore.user?.friends ?? []
        if let currentUser = UaiFotosDataStore.user {
            self.friends?.insert(currentUser, at: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.friends?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCollectionViewCell.identifier, for: indexPath) as! AvatarCollectionViewCell
        
        if let friend = self.friends?[indexPath.row] {
            cell.userAvatar.kf.indicatorType = .activity
            cell.userAvatar.kf.setImage(with: friend.avatarUrl)
            cell.userName.text = friend.name
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let friend = UaiFotosDataStore.user?.friends?[indexPath.row] {
            let storyboard = UIStoryboard(name: "Profile", bundle: nil)
            let destinationVC = storyboard.instantiateInitialViewController() as! ProfileViewController
            var destinationDS = destinationVC.router!.dataStore!
            destinationDS.user = friend
            collectionView.viewController()?.show(destinationVC, sender: nil)
        }
    }
}
