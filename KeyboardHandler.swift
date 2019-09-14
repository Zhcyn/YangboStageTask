//
//  KeyboardHandler.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/11/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//


protocol KeyboardHandler: class {
    
    var didChangedWhenKeyboardShow: ((Bool, CGFloat) -> Void)? { get set }
    
    func keyboardWillShow(_ notification: Notification)
    func keyboardWillHide(_ notification: Notification)
    func startObservingKeyboardChanges()
    func stopObservingKeyboardChanges()
}


extension KeyboardHandler where Self: UIViewController {

    func startObservingKeyboardChanges() {
        // NotificationCenter observers
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardWillShow(notification)
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { [weak self] notification in
            self?.keyboardWillHide(notification)
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    func keyboardWillHide(_ notification: Notification) {
        adjustingHeight(show: false, notification: notification)
    }
    
    private func adjustingHeight(show: Bool, notification: Notification) {
        var userInfo = notification.userInfo!
        let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
//        let animationDurarion = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
        let changeInHeight = keyboardFrame.height
        
        didChangedWhenKeyboardShow?(show, changeInHeight)
    }
    
    func stopObservingKeyboardChanges() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
