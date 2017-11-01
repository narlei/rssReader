//
//  FeedListViewController.swift
//  rssReader
//
//  Created by Narlei A Moreira on 31/10/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit

class FeedListViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var tableViewList: UITableView!
    
    // MARK: Properties
    
    var viewModel:FeedViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewList.estimatedRowHeight = CGFloat(100)
        self.tableViewList.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func openMenu(){
        panel?.openLeft(animated: true)
    }
    
    func initialize(viewModel:FeedViewModelProtocol) {
        self.viewModel = viewModel
        self.title = viewModel.getTitle()
        self.loadData()
    }
    
    func loadData() {
        self.viewModel.reload { (finished) in
            DispatchQueue.main.async {
                self.title = self.viewModel.getTitle()
                self.tableViewList.reloadData()
            }
        }
    }
    
}

extension FeedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = self.viewModel.getItems()[indexPath.row]
        let viewController = R.storyboard.feedDetail().instantiateInitialViewController() as! FeedDetailViewController
        viewController.rssItem = item
        self.navigationController?.pushViewController(viewController, animated: true)
        self.tableViewList.deselectRow(at: indexPath, animated: true)
    }
}

extension FeedListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = self.viewModel {
            return viewModel.getItems().count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellList", for: indexPath) as! FeedListCell
        let item = self.viewModel.getItems()[indexPath.row]
        cell.initialize(item: item)
        return cell
    }
}
