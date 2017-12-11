//
//  UserDTO.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 08/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation
import UIKit

struct UserDTO {
    var name: String?
    var title: String?
    var email: String?
    var avatar: String?
    
    var avatarUrl: URL {
        get {
            return URL(string: avatar!)!
        }
    }
    
    var photos: [PhotoDTO]?
    var friends: [UserDTO]?
}
