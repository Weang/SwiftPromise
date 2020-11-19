//
//  PermissionStatus.swift
//  permission
//
//  Created by Mr.wang on 2018/12/10.
//  Copyright © 2018 Mr.wang. All rights reserved.
//

public enum PermissionStatus {
    case authorized
    case denied
    case notDetermined
    case invalid
    case disabled
    
    var description: String {
        switch self {
        case .authorized: return "Authorized"
        case .denied: return "Denied"
        case .notDetermined: return "Not Determined"
        case .invalid: return "Invalid"
        case .disabled: return "Disabled"
        }
    }
}
