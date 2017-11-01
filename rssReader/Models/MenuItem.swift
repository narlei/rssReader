//
//  MenuItem.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit

struct MenuItem {
    var title:String?
    var url:String!

    init(title: String?, url: String!) {
        self.title = title
        self.url = url
    }
}
