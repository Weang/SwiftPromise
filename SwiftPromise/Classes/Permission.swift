//
//  Permission.swift
//  permission
//
//  Created by Mr.wang on 2018/12/10.
//  Copyright © 2018 Mr.wang. All rights reserved.
//

import UIKit

public protocol Permission {
    static var isAuthorized: Bool { get }
    static var status: PermissionStatus { get }
    static func requestPermission(_ closure: @escaping (PermissionStatus) -> ())
}

public extension Permission {
    
    static var isAuthorized: Bool {
        return status == .authorized
    }
    
}
