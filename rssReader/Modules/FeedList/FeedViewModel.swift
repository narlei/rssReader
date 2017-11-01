//
//  FeedViewModel.swift
//  rssReader
//
//  Created by Narlei A Moreira on 01/11/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit

protocol FeedViewModelProtocol {
    /// Reload rss object
    func reload(onComplete:@escaping (Bool) -> Void)
    
    /// Return title of Rss
    func getTitle() -> String
    
    /// Return all items
    func getItems() -> [RssItem]
}

class FeedViewModel: FeedViewModelProtocol {
    var rss:Rss!
    
    func initialize(url:String) {
        self.rss = Rss()
        self.rss.url = url
    }
    
    func getTitle() -> String {
        if let title = rss.title {
            return title
        }
        return "Carregando..."
    }
    
    func getItems() -> [RssItem] {
        if let array = rss.arrayItems {
            return array
        }
        return [RssItem]()
    }
    
    func reload(onComplete:@escaping (Bool) -> Void){
        RssService.getData(url: rss.url) { (result) in
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
