//
//  UIApplication+.swift
//  DoItToday
//
//  Created by nguyen.duc.huyb on 7/15/19.
//  Copyright © 2019 nguyen.duc.huyb. All rights reserved.
//

extension UIApplication {
    static func topViewController(base: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        
        return base
    }
}
