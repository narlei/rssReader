//
//  MenuViewController.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit
import FAPanels

class MenuViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var tableViewMenu: UITableView!
    
    // MARK: Properties
    var arrayItems = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        panel?.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadMenuItems()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func loadMenuItems(){
        
        self.arrayItems = NSMutableArray()

        if let array = MenuItemsManager.getItems() {
            self.arrayItems.addObjects(from: array as! [Any])
        }
        
        self.tableViewMenu.reloadData()
//        self.arrayItems.add(MenuItem(title: "AutoNews", url: "http://revistaautoesporte.globo.com/Revista/Autoesporte/Rss/0,,EDT0-10142,00.xml"))
//        self.arrayItems.add(MenuItem(title: "Profissionais TI", url: "http://feeds2.feedburner.com/profissionaisti"))
//        self.arrayItems.add(MenuItem(title: "Nao entendo", url: "http://feeds.feedburner.com/Naointendo"))
//        self.arrayItems.add(MenuItem(title: "iTunes", url: "https://itunes.apple.com/br/rss/customerreviews/id=866078699/sortBy=mostRecent/xml"))
    }
    
    

}

extension MenuViewController: FAPanelStateDelegate {
    func leftPanelWillBecomeActive() {
        self.loadMenuItems()
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
