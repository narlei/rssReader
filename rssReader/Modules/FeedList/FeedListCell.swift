//
//  FeedListCell.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit
import AlamofireRSSParser
import SDWebImage
import DateToolsSwift

class FeedListCell: UITableViewCell {

    
    // MARK: Outlets
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var imageViewCover: UIImageView!
    
    // MARK: Properties
    var rssItem:RSSItem!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func initialize(item: RSSItem) {
        self.rssItem = item
        self.labelTitle.text = item.title
        
        if let date = item.pubDate {
            self.labelDate.text = "publicado em " + date.format(with: "dd/MM/yyyy")
        }else{
            self.labelDate.text = ""
        }
        
        let str = item.itemDescription?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        self.labelText.text = str
        
        self.imageViewCover.image = UIImage()
        
        if let imageUrl = item.mediaThumbnail {
            self.imageViewCover.sd_setImage(with: URL(string:imageUrl), completed: nil)
        }else{
            if (item.imagesFromDescription != nil) && item.imagesFromDescription!.count > 0 {
                let imageUrl = item.imagesFromDescription!.first!
                self.imageViewCover.sd_setImage(with: URL(string:imageUrl), completed: nil)
            }
        }
    }
    
}
