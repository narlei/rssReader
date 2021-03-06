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
    @IBOutlet weak var emptyView: UIView!
    
    // MARK: Properties
    
    var viewModel:FeedViewModelProtocol!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewList.estimatedRowHeight = CGFloat(100)
        self.tableViewList.rowHeight = UITableViewAutomaticDimension
        
        // Refresh Control
        self.refreshControl = UIRefreshControl()
        self.refreshControl.addTarget(self, action: #selector(self.loadData(keep:)), for: .valueChanged)
        self.tableViewList.addSubview(self.refreshControl)
        
        self.registerForPreviewing(with: self, sourceView: self.tableViewList)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func openMenu(){
        panel?.openLeft(animated: true)
    }
    
    @IBAction func openAddItem(){
        self.addItem()
    }
    
    func initialize(viewModel:FeedViewModelProtocol) {
        self.viewModel = viewModel
        self.title = viewModel.getTitle()
        self.loadData(keep: true)
    }
    
    @objc func loadData(keep:Bool = true) {
        if keep && self.viewModel.getItems().count > 0 {
            DispatchQueue.main.async {
                self.title = self.viewModel.getTitle()
                self.tableViewList.reloadData()
                self.refreshControl.endRefreshing()
                self.loadEmtpyView()
            }
            return
        }
        
        self.viewModel.reload { (success) in
            DispatchQueue.main.async {
                self.title = self.viewModel.getTitle()
                self.tableViewList.reloadData()
                self.refreshControl.endRefreshing()
                self.loadEmtpyView()
                
                if !success {
                    let alert = UIAlertController(title: "Atenção", message: "O Feed do Rss não pode ser carregado!", preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
                    }
                    alert.addAction(okAction)
                    self.present(alert, animated: true) {
                    }
                }
            }
        }
    }
    
    func loadEmtpyView(){
        if self.viewModel != nil && self.viewModel.getItems().count > 0 {
            self.emptyView.isHidden = true
        }else{
            self.emptyView.isHidden = false
        }
    }
    
    func addItem(){
        let alert = UIAlertController(title: "Adicionar Feed", message: "Insira a URL de Feed RSS", preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = ""
            textField.placeholder = "Nome"
            textField.tag = 1
        }
        
        alert.addTextField { (textField) in
            textField.text = ""
            textField.placeholder = "Url do RSS"
            textField.tag = 2
        }
        
        alert.addAction(UIAlertAction(title: "Salvar", style: .default, handler: { [weak alert] (_) in
            let menuItem = MenuItem()
            for textField in alert!.textFields! {
                if textField.tag == 1 {
                    menuItem.title = textField.text
                }
                if textField.tag == 2 {
                    menuItem.url = textField.text
                }
            }
            
            MenuItemsManager.save(item: menuItem)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
extension FeedListViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = self.tableViewList.indexPathForRow(at: location) {
            let item = self.viewModel.getItems()[indexPath.row]
            let viewController = R.storyboard.feedDetail().instantiateInitialViewController() as! FeedDetailViewController
            viewController.rssItem = item
            previewingContext.sourceRect = self.tableViewList.rectForRow(at: indexPath)
            return viewController
            
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.navigationController?.pushViewController(viewControllerToCommit, animated: true)
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
