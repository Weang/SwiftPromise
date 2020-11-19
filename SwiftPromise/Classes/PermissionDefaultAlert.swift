//
//  PermissionDefaultAlert.swift
//  SwiftPromise_Example
//
//  Created by Mr.Wang on 2020/1/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public class PermissionDefaultAlert: PermissionAlert {
    
    public init() {
        
    }
    
    public func showAlert(_ permission: PermissionType, status: PermissionStatus, cancelClosuer: @escaping () -> ()) {
        let appName = (Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String) ?? ""
        let message: String
        switch status {
        case .denied:
            message = "请在iPhone的“设置”中，允许\(appName)访问你的\(permission.displayText)。"
        case .invalid, .disabled:
            message = "\(permission.displayText)当前不可用。"
        default:
            return
        }
        let alert = UIAlertController.init(title: "无法访问\(permission.displayText)", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "设置", style: .default, handler: { (_) in
            if let url = URL.init(string: UIApplication.openSettingsURLString) {
                if #available(iOS 10, *) {
                    UIApplication.shared.open(url)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
            cancelClosuer()
        }))
        alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (_) in
            cancelClosuer()
        }))
        UIViewController.topMost?.present(alert, animated: true, completion: nil)
    }

}

fileprivate extension UIViewController {
    
    static var topMost: UIViewController? {
        let window = UIApplication.shared.windows.first {
            $0.rootViewController != nil && $0.isKeyWindow
        }
        return self.topMost(of: window?.rootViewController)
    }
    
    static func topMost(of viewController: UIViewController?) -> UIViewController? {
        // presented view controller
        if let presentedViewController = viewController?.presentedViewController {
            return self.topMost(of: presentedViewController)
        }
        
        // UITabBarController
        if let tabBarController = viewController as? UITabBarController,
            let selectedViewController = tabBarController.selectedViewController {
            return self.topMost(of: selectedViewController)
        }
        
        // UINavigationController
        if let navigationController = viewController as? UINavigationController,
            let visibleViewController = navigationController.visibleViewController {
            return self.topMost(of: visibleViewController)
        }
        
        // UIPageController
        if let pageViewController = viewController as? UIPageViewController,
            pageViewController.viewControllers?.count == 1 {
            return self.topMost(of: pageViewController.viewControllers?.first)
        }
        
        // child view controller
        for subview in viewController?.view?.subviews ?? [] {
            if let childViewController = subview.next as? UIViewController {
                return self.topMost(of: childViewController)
            }
        }
        
        return viewController
    }
}
