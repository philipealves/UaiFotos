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
        
        for _ in 0..<number {
            let photo = PhotoDTO(picsumImage: UaiFotosDataStore.picsumImageList?.randomItem(), description: Randoms.randomFakeConversation(), likes: Int.random(), views: Int.random(), liked: Bool.random(), favorited: false,location: generateRandomLocale(title: Randoms.randomFakeConversation(), subtitle: Randoms.randomFakeConversation()))
            photoList.append(photo)
        }
        return photoList
    }
    
    private func generateRandomLocale(title : String, subtitle : String) -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        //annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(randomBetweenNumbers(firstNum: -90, secondNum: 90)), longitude: CLLocationDegrees(randomBetweenNumbers(firstNum: -180, secondNum: 180)))
        
//        -18.898220, -48.274420
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(-18.898220), longitude: CLLocationDegrees(-48.274420))
        
        //-180 is the minimum of longitude and 180 is the maximum
        //-90 is the minimum of latitude and 90 is the maximum
        annotation.title = title
        annotation.subtitle = subtitle
        return annotation
    }
    
    private func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
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
    
}
