//
//  FeedViewModel.swift
//  rssReader
//
//  Created by Narlei A Moreira on 01/11/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit
import AlamofireRSSParser

protocol FeedViewModelProtocol {
    /// Reload rss object
    func reload(onComplete:@escaping (Bool) -> Void)
    
    /// Return title of Rss
    func getTitle() -> String
    
    /// Return all items
    func getItems() -> [RSSItem]
}

class FeedViewModel: FeedViewModelProtocol {
    var rss:RSSFeed!
    var url:String!
    
    func initialize(url:String) {
        self.url = url
    }
    
    func getTitle() -> String {
        if rss != nil {
            return rss.title ?? "Unknown"
        }
        return "Carregando..."
    }
    
    func getItems() -> [RSSItem] {
        if rss != nil {
            return rss.items
        }
        return [RSSItem]()
    }
    
    func reload(onComplete:@escaping (Bool) -> Void){
        
        RssService.getDataParsed(url: self.url) { (result) in
            switch result {
            case .success(let response):
                self.rss = response
            case .failure(let _):
                break
            }
            onComplete(true)
        }
    }
}
