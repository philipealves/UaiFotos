//
//  LocationDTO.swift
//  Uai Fotos
//
//  Created by Aloc SP08608 on 14/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation

class LocationDTO {
    
    var latitude : Double
    var longitude : Double
    var city : String
    var description : String

    init(city : String, description : String, latitude : Double, longitude : Double) {
        self.city = city        
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }
}
