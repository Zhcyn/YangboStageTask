//
//  UIScrollView+.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/15/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

extension UIScrollView {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard(_ gesture : UITapGestureRecognizer) {
        self.endEditing(true)
    }
}
