//
//  FeedDetailViewController.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit
import WebKit
import AlamofireRSSParser

class FeedDetailViewController: UIViewController {
    
    var rssItem:RSSItem!

    @IBOutlet weak var webViewText: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = rssItem.title
        
        if let descript = rssItem.itemDescription {
            self.webViewText.loadHTMLString(descript, baseURL: nil)
        }else{
            if let descript = rssItem.content {
                let html = """
                    <html lang="en"><head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="initial-scale=1">
                    <body>
                    \(descript)
                    </body>
                """
                self.webViewText.loadHTMLString(html, baseURL: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
