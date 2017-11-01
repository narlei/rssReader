//
//  MenuViewController.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var tableViewMenu: UITableView!
    
    // MARK: Properties
    var arrayItems = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMenuItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadMenuItems(){
        
        self.arrayItems = NSMutableArray()
        
        self.arrayItems.add(MenuItem(title: "AutoNews", url: "http://revistaautoesporte.globo.com/Revista/Autoesporte/Rss/0,,EDT0-10142,00.xml"))
        self.arrayItems.add(MenuItem(title: "Profissionais TI", url: "http://feeds2.feedburner.com/profissionaisti"))

    }

}


extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem = self.arrayItems.object(at: indexPath.row) as! MenuItem
        FeedManager.main.loadItem(url: menuItem.url!)
        panel?.closeLeft()
    }
    
}

extension MenuViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellMenu", for: indexPath) as! MenuCell
        cell.initialize(item: self.arrayItems.object(at: indexPath.row) as! MenuItem)
        return cell
    }
}
