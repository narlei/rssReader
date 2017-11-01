//
//  MenuCell.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet weak var labelTitle: UILabel!
    
    // MARK: Properties
    
    var menuItem:MenuItem!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initialize(item:MenuItem) {
        self.menuItem = item
        self.labelTitle.text = item.title
    }
    

}
