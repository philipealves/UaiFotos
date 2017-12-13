//
//  PicsumImageDTO.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 08/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation
import ObjectMapper

public class PicsumImageDTO: Mappable {
    var format: String?
    var width: Int?
    var height: Int?
    var filename: String?
    var id: Int?
    var author: String?
    var author_url: String?
    var post_url: String?
    
    init(format: String?, width: Int?, height: Int?, filename: String?, id: Int?, author: String?, author_url: String?, post_url: String?) {
        self.format = format
        self.width =  width
        self.height = height
        self.filename = filename
        self.id = id
        self.author = author
        self.author_url = author_url
        self.post_url = post_url
    }
    
    public required init?(map: Map) {
        if map.JSON["id"] == nil {
            return nil
        }
    }
    
    public func mapping(map: Map) {
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
