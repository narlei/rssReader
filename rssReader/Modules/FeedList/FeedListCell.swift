//
//  FeedListCell.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit

class FeedListCell: UITableViewCell {

    
    // MARK: Outlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageViewCover: UIImageView!
    
    // MARK: Properties
    var rssItem:RssItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func initialize(item: RssItem) {
        self.rssItem = item
        self.labelTitle.text = item.title
        self.labelText.text = item.text
    }
    
}
