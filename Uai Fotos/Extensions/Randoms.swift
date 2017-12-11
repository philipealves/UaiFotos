//
//  Randoms.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 07/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation
import SwiftRandom

extension Randoms {
    public static func randomImageUrl() -> String {
        //return "https://picsum.photos/1080/1080"
        return "https://picsum.photos/\(Int.random(0, 900) + 100)/?random"
    }
    
    public static func randomFakeEmail() -> String {
        var fakeName = self.randomFakeName()
        fakeName = fakeName.lowercased()
        fakeName = fakeName.replacingOccurrences(of: " ", with: ".")
        
        let domainList = ["scopus", "uol", "globo", "gmail", "yahoo", "hotmail", "g1", "mail", "google", "github", "stackoverflow"]
        let suffixList = ["com.br", "com", "net", "net.br", "co.uk", "me", "us", "com.vc", "org", "co.nl", "blog.br", "xyz", "edu.br"]
        
        return "\(fakeName)@\(domainList.randomItem()!).\(suffixList.randomItem()!)"
    }
    
    public static func randomFakeGravatarUrl() -> String {
        let options = [Randoms.GravatarStyle.Standard, Randoms.GravatarStyle.MM, Randoms.GravatarStyle.Identicon, Randoms.GravatarStyle.MonsterID, Randoms.GravatarStyle.Wavatar, Randoms.GravatarStyle.Retro]
        let style = options.random()
        var url = "https://secure.gravatar.com/avatar/thisimagewillnotbefound?s=\(80)"
        if style != .Standard {
            url += "&d=\(style.rawValue.lowercased())"
        }
        return url
    }
}
