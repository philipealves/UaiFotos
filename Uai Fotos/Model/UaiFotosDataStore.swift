//
//  UaiFotosDataStore.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 08/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation
import SwiftRandom

class UaiFotosDataStore {
    
    public static var user: UserDTO?
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
        for _ in 0..<number {
            let comments = self.genetareComments()
            let photo = PhotoDTO(picsumImage: UaiFotosDataStore.picsumImageList?.randomItem(), description: Randoms.randomFakeConversation(), likes: Int.random(), views: Int.random(), liked: Bool.random(), favorited: false,
                                 comments: comments)
            photoList.append(photo)
        }
        return photoList
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
    
    public var userCurrent: UserDTO? {
        get {
            return UaiFotosDataStore.user
        }
        set {
            UaiFotosDataStore.user?.name = newValue?.name
            UaiFotosDataStore.user?.email = newValue?.email
            UaiFotosDataStore.user?.birthday = newValue?.birthday
            UaiFotosDataStore.user?.gender = newValue?.gender
            UaiFotosDataStore.user?.website = newValue?.website
            UaiFotosDataStore.user?.phone = newValue?.phone
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
