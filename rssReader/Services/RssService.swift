//
//  RssService.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyXMLParser


enum Result<T> {
    case success(T)
    case failure(Error)
}

class RssService {
    
    class func getData(url:String, onComplete:@escaping (Result<Rss>)-> Void) {
        
        Alamofire.request(url).response { (response) in
            if let data = response.data {
                let xml = XML.parse(data)
                
                let rssXml = xml["rss"]["channel"]
                
                var arrayReturn = [RssItem]()
                
                for item in rssXml["item"] {
                    var rssItem = RssItem()
                    if let title = item["title"].text {
                        rssItem.title = title
                    }
                    if let title = item["description"].text {
                        rssItem.text = title
                    }
                    if let title = item["content:encoded"].text {
                        rssItem.text = title
                    }
                    if let title = item["link"].text {
                        rssItem.link = title
                    }
                    if let title = item["image"].text {
                        rssItem.image = title
                    }
                    arrayReturn.append(rssItem)
                }
                
                var rss = Rss()
                rss.url = url
                rss.arrayItems = arrayReturn
                rss.title = rssXml["title"].text

                
                onComplete(.success(rss))
            }
        }
    }
    
}
