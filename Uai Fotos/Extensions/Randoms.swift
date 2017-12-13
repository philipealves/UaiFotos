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
    
    public static func randomFakeBrazilianName() -> String {
        
        let firstNameList = ["Davi",    "Alice", "Arthur",        "Julia", "Pedro", "Isabella",
                             "Gabriel", "Manuela","Bernardo" ,  "Laura",
                             "Lucas", "Luiza", "Matheus", "Valentina",
                             "Rafael", "Giovanna",
                             "Heitor"    ,"Maria Eduarda",
                             "Enzo"  ,  "Helena",
                             "Guilherme",     "Beatriz",
                             "Nicolas",   "Maria Luiza",
                             "Lorenzo",    "Lara",
                             "Gustavo"]
        let lastNameList = ["Fernandes", "Santana", "Carvalho", "Martins", "Santos", "Boaventura", "Oliveira", "Moraes", "Leão", "Garcia", "Alves", "Costa", "Oliveira", "Martinez", "Novaes", "Oliveira", "Araújo", "Maia", "Vasconcelos", "Gonçalves", "Guimarães", "Menezes", "Sampaio", "Cavalcante", "Lacerda", "Mello", "Moraes", "Muniz", "Figueira", "Paes", "Lima", "Marques", "Duarte", "Vasconcelos", "Vieira", "Souza", "Soares", "Silva", "Duarte", "Morais", "Gomes", "Paiva", "Junqueira", "Queiroz", "Barreto", "Menezzes", "Campos", "Pilar", "Chaves", "Paris", "Lessa", "Galisteu", "Garcia", "Frota", "Araújo", "Xavier"]
        return firstNameList.randomItem()! + " " + lastNameList.randomItem()!
    }
    
    
}

/*
 Miguel    1    Sophia
 2    Davi    2    Alice
 3    Arthur    3    Julia
 4    Pedro    4    Isabella
 5    Gabriel    5    Manuela
 6    Bernardo    6    Laura
 7    Lucas    7    Luiza
 8    Matheus    8    Valentina
 9    Rafael    9    Giovanna
 10    Heitor    10    Maria Eduarda
 11    Enzo    11    Helena
 12    Guilherme    12    Beatriz
 13    Nicolas    13    Maria Luiza
 14    Lorenzo    14    Lara
 15    Gustavo
 */
