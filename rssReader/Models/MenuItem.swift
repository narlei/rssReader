//
//  MenuItem.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit

class MenuItem: NSObject, NSCoding {
    var title:String?
    var url:String!

    override init(){
        
    }
    
    init(title: String?, url: String!) {
        self.title = title
        self.url = url
    }
    
    required init?(coder decoder: NSCoder) {
        super.init()
        
        title = decoder.decodeObject(forKey: "title") as? String
        url = decoder.decodeObject(forKey: "url") as! String
    }
   
    func encode(with coder: NSCoder) {
        coder.encode(title, forKey: "title")
        coder.encode(url, forKey: "url")
    }
}
