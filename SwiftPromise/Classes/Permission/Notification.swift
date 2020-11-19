//
//  Notification.swift
//  SwiftPromise
//
//  Created by Mr.Wang on 2020/11/19.
//

import UIKit

struct Notification: Permission {
    
    fileprivate static let requestedNotificationsKey = "requestedNotifications"
    
    static var status: PermissionStatus {
        if UserDefaults.standard.object(forKey: requestedNotificationsKey) != nil {
            return synchronousStatusNotifications
        }
        return .notDetermined
    }
    
    static func requestPermission(_ closure: @escaping (PermissionStatus) -> ()) {
        guard status == .notDetermined else {
            closure(status)
            return
        }
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert]) { (_, _) in
            UserDefaults.standard.setValue(true, forKey: requestedNotificationsKey)
            closure(status)
        }
    }
    
    fileprivate static var synchronousStatusNotifications: PermissionStatus {
        let semaphore = DispatchSemaphore(value: 0)
        
        var status: PermissionStatus = .notDetermined
        
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized: status = .authorized
            case .denied: status = .denied
            case .notDetermined: status = .notDetermined
            case .provisional: status = .authorized
            case .ephemeral: status = .authorized
            @unknown default: status = .notDetermined
            }
            
            semaphore.signal()
        }
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return status
    }
}
