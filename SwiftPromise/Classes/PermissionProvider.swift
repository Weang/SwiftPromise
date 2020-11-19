//
//  PermissionProvider.swift
//  permission
//
//  Created by Mr.wang on 2018/12/10.
//  Copyright © 2018 Mr.wang. All rights reserved.
//

import UIKit

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
        
        switch type.permission.status {
        case .authorized:
            complete()
        case .notDetermined:
            type.permission.requestPermission { _ in
                DispatchQueue.main.async {
                    switch type.permission.status {
                    case .authorized:
                        complete()
                    default:
                        if let alertDelegate = alertDelegate {
                            alertDelegate.showAlert(type, status: type.permission.status) {
                                failure()
                            }
                        } else {
                            failure()
                        }
                    }
                }
            }
        default:
            if let alertDelegate = alertDelegate {
                alertDelegate.showAlert(type, status: type.permission.status) {
                    failure()
                }
            } else {
                failure()
            }
        }
    }
}
