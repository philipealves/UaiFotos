//
//  UserDTO.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 08/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation
import UIKit

class UserDTO {
    var name: String?
    var title: String?
    var email: String?
    var avatar: String?
    
    var photos: [PhotoDTO]?
    var friends: [UserDTO]?
    
    
    init (name: String?, title: String?, email: String?, avatar: String?, photos: [PhotoDTO]?, friends: [UserDTO]?) {
        self.name = name
        self.title = title
        self.email = email
        self.avatar = avatar
        self.photos = photos
        self.friends = friends
    }
    
    var avatarUrl: URL {
        get {
            return URL(string: avatar!)!
        }
    }
    
}
