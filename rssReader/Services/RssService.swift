//
//  RssService.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireRSSParser


enum Result<T> {
    case success(T)
    case failure(Error)
}

class RssService {
    
    class func getDataParsed(url:String, onComplete:@escaping (Result<RSSFeed>)-> Void) {
        
        Alamofire.request(url).responseRSS() { (response) -> Void in
            if let feed: RSSFeed = response.result.value {
                onComplete(.success(feed))
            }else{
                if let error = response.error {
                    onComplete(.failure(error))
                }else{
                    let error = NSError(domain:"", code:601, userInfo:nil)
                    onComplete(.failure(error))
                }
            }
        }
    }
    
}
