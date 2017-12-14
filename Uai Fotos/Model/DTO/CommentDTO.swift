//
//  CommentDTO.swift
//  Uai Fotos
//
//  Created by Daniel Garcia on 14/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation

class CommentDTO {
    
    var textComment: String?
    var user: UserDTO

    init(comment: String, user: UserDTO) {
        self.textComment = comment
        self.user =  user
    }
    
}
