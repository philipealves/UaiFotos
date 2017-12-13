//
//  PhotoDTO.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 08/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation
import MapKit

struct PhotoDTO {
    var picsumImage: PicsumImageDTO?
    var description: String?
    var likes: Int
    var views: Int
    var liked: Bool
    var location: MKPointAnnotation?
    
    var imageUrl: URL {
        get {
            var urlString = "https://picsum.photos/1080?image="
            if let picsum = picsumImage {
                urlString = urlString + String((picsum.id ?? 0))
            }
            return URL(string: urlString)!
        }
    }
    
    var photoCaption: String {
        get {
            let stringArray = ["\(views) visualizações", "\(likes) curtidas"]
            return stringArray.randomItem()!
        }
    }
    
}
