//
//  AvatarCollectionView.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 07/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit

class AvatarCollectionData: NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UaiFotosDataStore.user?.friends?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AvatarCollectionViewCell.identifier, for: indexPath) as! AvatarCollectionViewCell
        
        if let friend = UaiFotosDataStore.user?.friends?[indexPath.row] {
            cell.userAvatar.kf.indicatorType = .activity
            cell.userAvatar.kf.setImage(with: friend.avatarUrl)
            cell.userName.text = friend.name
        }
        
        
        return cell
    }
}
