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
    
    var website : String?
    var gender : String?
    var phone : String?
    var birthday : String?
    
    var photos: [PhotoDTO]?
    var friends: [UserDTO]?
    
    
    convenience init (name: String?, title: String?, email: String?, avatar: String?, photos: [PhotoDTO]?, friends: [UserDTO]?) {
        self.init(name: name, title: title, email: email, avatar: avatar, photos: photos, friends: friends, website: "", gender: "", phone: "", birthday: "")
    }
    
    init (name: String?, title: String?, email: String?, avatar: String?, photos: [PhotoDTO]?, friends: [UserDTO]?, website: String?, gender: String?, phone: String?, birthday: String?) {
        self.name = name
        self.title = title
        self.email = email
        self.avatar = avatar
        self.photos = photos
        self.friends = friends
        self.website = website
        self.gender = gender
        self.phone = phone
        self.birthday = birthday
    }
    
    var avatarUrl: URL {
        get {
            return URL(string: avatar!)!
        }
    }
    
}
