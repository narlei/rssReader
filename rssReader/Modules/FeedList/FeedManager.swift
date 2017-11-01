//
//  FeedManager.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit

class FeedManager {
    
    
    static let main = FeedManager()
    private init() {
    }
    
    var arrayViewModels = [FeedViewModel]()
    
    func loadItem(url:String) {
        var viewModel = FeedViewModel()
        viewModel.initialize(url: url)
        
        let viewModels = self.arrayViewModels.filter({$0.rss.title == url})
        if viewModels.count > 0 {
            viewModel = viewModels.first!
        }
     
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.getFeedList().initialize(viewModel: viewModel)
    }
}
