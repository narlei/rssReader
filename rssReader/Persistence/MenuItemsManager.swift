//
//  MenuItemsManager.swift
//  rssReader
//
//  Created by Narlei A Moreira on 01/11/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit

class MenuItemsManager {
    
    class func save(item:MenuItem) {
        
        if item.title!.isEmpty || item.url.isEmpty {
    
            UIAlertController.showAlert(title: "Atenção", description: "Nome e URL são obrigatórios!")

            return
        }
        
        // create NSURL instance
        if let url = NSURL(string: item.url) {
            // check if your application can open the NSURL instance
            if  !UIApplication.shared.canOpenURL(url as URL) {
                UIAlertController.showAlert(title: "Atenção", description: "A URL não é válida!")
                return
            }
        }

        let data = UserDefaults.standard.value(forKey: Constants.rssSaveKey) as? Data
        
        var arrayItems = NSMutableArray()
        
        if data != nil {
            arrayItems = NSKeyedUnarchiver.unarchiveObject(with: data!) as! NSMutableArray
        }
        
        arrayItems.add(item)
        
        UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject: arrayItems), forKey: Constants.rssSaveKey)
    }
    
    class func getItems() -> NSMutableArray? {
        let data = UserDefaults.standard.value(forKey: Constants.rssSaveKey) as? Data
        
        var arrayItems = NSMutableArray()
        
        if data != nil {
            arrayItems = NSKeyedUnarchiver.unarchiveObject(with: data!) as! NSMutableArray
            return arrayItems
        }
        return nil
    }
    
}
