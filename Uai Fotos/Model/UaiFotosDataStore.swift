//
//  UaiFotosDataStore.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 08/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation
import SwiftRandom
import MapKit

class UaiFotosDataStore {
    
    static var user: UserDTO?
    static var picsumImageList: [PicsumImageDTO]?
    
    var feedPhotos: [(photo: PhotoDTO, friend: UserDTO)]? {
        get {
            guard UaiFotosDataStore.user != nil else {
                return nil
            }
            var feed = [(photo: PhotoDTO, friend: UserDTO)]()
            for user in UaiFotosDataStore.user!.friends! {
                guard user.photos != nil else { return nil }
                for photo in user.photos! {
                    feed.append((photo: photo, friend: user))
                }
            }
            return feed.sorted(by: { _,_ in arc4random() < arc4random() })
        }
    }
    
    public func generateFeed(photoNumber: Int) {
        guard UaiFotosDataStore.picsumImageList != nil else { return }
        
        let myUser = UserDTO(name: Randoms.randomFakeBrazilianName(), title: Randoms.randomFakeTitle(), email: Randoms.randomFakeEmail(), avatar: Randoms.randomFakeGravatarUrl(), photos: self.generatePhotos(number: photoNumber), friends: self.generateUsers(number: Int.random()))
        
        UaiFotosDataStore.user = myUser
    }
    
    public func generateUsers(number: Int) -> [UserDTO] {
        var userList = [UserDTO]()
        
        for _ in 0..<number {
            let user = UserDTO(name: Randoms.randomFakeBrazilianName(), title: Randoms.randomFakeTitle(), email: Randoms.randomFakeEmail(), avatar: Randoms.randomFakeGravatarUrl(), photos: self.generatePhotos(number: Int.random()), friends: nil)
            
            userList.append(user)
        }
        return userList
    }
    
    public func generatePhotos(number: Int) -> [PhotoDTO] {
        var photoList = [PhotoDTO]()

        for index in 0..<number {
            let comments = self.genetareComments()
            let photo = PhotoDTO(picsumImage: UaiFotosDataStore.picsumImageList?.randomItem(), description: Randoms.randomFakeConversation(), likes: Int.random(), views: Int.random(), liked: Bool.random(), favorited: false,
                                 comments: comments, generateRandomLocale(id: index))
            photoList.append(photo)
        }
        return photoList
    }
    
    private func generateRandomLocale(id : Int) -> LocationDTO {
        switch id % 4 {
        case 0:
            return LocationDTO(city: "Uberlândia", description: "Center Shopping", latitude: -18.909817, longitude: -48.260614)
        case 1:
            return LocationDTO(city: "Patos de Minas", description: "Terra do Milho", latitude: -18.5983365, longitude: -46.5351996)
        case 2:
            return LocationDTO(city: "São Paulo", description: "Aqui nunca dorme", latitude: -23.5505199, longitude: -46.6333094)
        default:
            return LocationDTO(city: "Curitiba", description: "Frrriiiooo", latitude: -25.4290219, longitude: -49.2673976)
        }
    }
    


    // Activity Data Store
    var userActivity: [(photo: PhotoDTO, friend: UserDTO, type: String)]? {
        get {
            guard UaiFotosDataStore.user != nil else {
                return nil
            }
            var feed = [(photo: PhotoDTO, friend: UserDTO, type: String)]()
            for user in UaiFotosDataStore.user!.friends! {
                guard user.photos != nil else { return nil }
                for photo in user.photos! {
                    feed.append((photo: photo, friend: user, type: "Following"))
                }
            }
            return feed.sorted(by: { _,_ in arc4random() < arc4random() })
        }
    }
    
    func genetareComments() -> [CommentDTO]{
        var comments = [CommentDTO]()
        let number = Randoms.randomInt(1, 20)
        
        for _ in 0..<number {
            let user = UserDTO(name: Randoms.randomFakeBrazilianName(), title: Randoms.randomFakeTitle(), email: Randoms.randomFakeEmail(), avatar: Randoms.randomFakeGravatarUrl(), photos: nil, friends: nil)
            let comment = CommentDTO(comment: Randoms.randomFakeConversation(), user: user)
            comments.append(comment)
        }
        return comments
    }
    
}
