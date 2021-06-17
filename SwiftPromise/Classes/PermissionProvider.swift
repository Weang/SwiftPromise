//
//  PermissionProvider.swift
//  permission
//
//  Created by Mr.wang on 2018/12/10.
//  Copyright © 2018 Mr.wang. All rights reserved.
//

import UIKit
import TaskQueue

public struct PermissionProvider {
    
    public static func statusFor(_ type: PermissionType) -> PermissionStatus {
        return type.permission.status
    }
    
    public static func request(_ type: PermissionType,
                               alertDelegate: PermissionAlert? = PermissionDefaultAlert(),
                               complete: @escaping () -> () = {},
                               failure: @escaping () -> () = {}) {
        if let infoDescription = type.infoDescription,
           Bundle.main.object(forInfoDictionaryKey: infoDescription) == nil {
            fatalError("请在info.plist中添加\(infoDescription)")
        }
        
        func completeHandle() {
            DispatchQueue.main.async {
                complete()
            }
        }
        
        func failureHandle() {
            DispatchQueue.main.async {
                if let alertDelegate = alertDelegate {
                    alertDelegate.showAlert(type, status: type.permission.status) {
                        failure()
                    }
                } else {
                    failure()
                }
            }
        }
        
        switch type.permission.status {
        case .authorized:
            completeHandle()
        case .notDetermined:
            type.permission.requestPermission { status in
                switch status {
                case .authorized:
                    completeHandle()
                default:
                    failureHandle()
                }
            }
        default:
            failureHandle()
        }
        
    }
    
    public static func request(_ types: [PermissionType],
                               alertDelegate: PermissionAlert? = PermissionDefaultAlert(),
                               complete: @escaping () -> () = {},
                               failure: @escaping () -> () = {}) {
        let queue = TaskQueue()
        
        queue.tasks = types.map { type -> TaskQueue.ClosureWithResultNext in
            return { _, next in
                request(type, alertDelegate: alertDelegate) {
                    next(nil)
                } failure: {
                    failure()
                    queue.removeAll()
                }
            }
        }
        queue.run {
            DispatchQueue.main.async {
                complete()
            }
        }
    }
    
}
