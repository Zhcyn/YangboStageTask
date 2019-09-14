//
//  UIViewController+.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/10/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

extension UIViewController {
    func hideKeyboardWhenTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGestureRecognizer))
        tapGesture.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleTapGestureRecognizer(_ gesture: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func showAlert(title: String?, message: String?) {
        let ac = UIAlertController(title: title,
                                   message: message,
                                   preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        
        ac.addAction(okAction)
        present(ac, animated: true, completion: nil)
    }
    
    func showFullAlert(title: String, msg: String, completion: ((Bool) -> Void)?) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            completion?(true)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func configRealmError() {
        //Handle Realm Error
        RealmService.shared.observeRealmErrors(in: self) { [weak self] (error) in
            guard let self = self else { return }
            self.showAlert(title: "Error", message: error?.localizedDescription ?? "no error detected")
        }
    }
}
