//
//  UIAlertViewExtension.swift
//  rssReader
//
//  Created by Narlei A Moreira on 01/11/17.
//  Copyright © 2017 Narlei A Moreira. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func showAlert(title:String?, description:String?) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (UIAlertAction) in
            
        }
        
        alert.addAction(okAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true) {
        }

    }
}
