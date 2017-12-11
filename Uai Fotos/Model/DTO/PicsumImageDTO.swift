//
//  PicsumImageDTO.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 08/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation
import ObjectMapper

public struct PicsumImageDTO: Mappable {
    var format: String?
    var width: Int?
    var height: Int?
    var filename: String?
    var id: Int?
    var author: String?
    var author_url: String?
    var post_url: String?
    
    public init?(map: Map) {
        if map.JSON["id"] == nil {
            return nil
        }
    }
    
    public mutating func mapping(map: Map) {
        self.format     <- map["format"]
        self.width      <- map["width"]
        self.height     <- map["height"]
        self.filename   <- map["filename"]
        self.id         <- map["id"]
        self.author     <- map["author"]
        self.author_url <- map["author_url"]
        self.post_url   <- map["post_url"]
    }
}
