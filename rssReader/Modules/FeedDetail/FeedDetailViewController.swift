//
//  FeedDetailViewController.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit
import WebKit


class FeedDetailViewController: UIViewController {
    
    var rssItem:RssItem!

    @IBOutlet weak var webViewText: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = rssItem.title
        self.webViewText.loadHTMLString(rssItem.text!, baseURL: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
