//
//  PicsumApi.swift
//  Uai Fotos
//
//  Created by Elifazio Bernardes da Silva on 08/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import Foundation
import ObjectMapper
//import AlamofireObjectMapper
import RxSwift
import RxAlamofire


public class PicsumApi {
    let api_url = "https://picsum.photos/list"
    
    public func photoList() -> Observable<[PicsumImageDTO]>  {
        return RxAlamofire
                .requestJSON(URLRequest(url: URL(string: self.api_url)!))
                .observeOn(OperationQueueScheduler(operationQueue: OperationQueue()))
                .debug()
                .map { (request) -> [PicsumImageDTO] in
                    return Mapper<PicsumImageDTO>().mapArray(JSONObject: request.1)!
                }
                .observeOn(MainScheduler.instance)
    }
    
}
