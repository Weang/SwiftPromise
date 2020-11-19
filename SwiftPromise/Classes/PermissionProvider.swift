//
//  PermissionProvider.swift
//  permission
//
//  Created by Mr.wang on 2018/12/10.
//  Copyright © 2018 Mr.wang. All rights reserved.
//

import UIKit

public struct PermissionProvider {
    
    public static func request(_ type: PermissionType,
                               alertDelegate: PermissionAlert = PermissionDefaultAlert(),
                               complete: @escaping () -> () = {},
                               failure: @escaping () -> () = {}) {
        guard let _ = Bundle.main.object(forInfoDictionaryKey: type.infoDescription) else {
            fatalError("请在info.plist中添加\(type.infoDescription)")
        }
        
        type.permission.requestPermission { _ in
            DispatchQueue.main.async {
                switch type.permission.status {
                case .authorized:
                    complete()
                default:
                    alertDelegate.showAlert(type, status: type.permission.status) {
                        failure()
                    }
                }
            }
        }
    }
    
    
}
