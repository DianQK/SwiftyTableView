//
//  Helper.swift
//  SwiftyTableView
//
//  Created by DianQK on 7/19/16.
//  Copyright © 2016 T. All rights reserved.
//

import UIKit

typealias Action = () -> ()

func header<T>(height: CGFloat) -> (T) -> CGFloat {
    return { value in
        return height
    }
}

func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
    if let nav = base as? UINavigationController {
        return topViewController(nav.visibleViewController)
    }
    if let tab = base as? UITabBarController
        , let selected = tab.selectedViewController {
            return topViewController(selected)
    }
    if let presented = base?.presentedViewController {
        return topViewController(presented)
    }
    return base
}

func showAlert(_ title: String?, message: String? = nil) -> Action {
    return {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        topViewController()?.show(alert, sender: nil)
    }
}

//func showAlert(title: String?, message: String? = nil) {
//    let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
//    alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
//    topViewController()?.showViewController(alert, sender: nil)
//}
