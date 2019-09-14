//
//  AlertMessage.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/15/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

class AlertMessage {
    static func showMessage(title: String, msg: String, completion: ((Bool) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            completion?(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}
