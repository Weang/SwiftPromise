//
//  Contacts.swift
//  SwiftPromise_Example
//
//  Created by Mr.Wang on 2020/1/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import Contacts

struct Contacts: Permission {
    
    static var status: PermissionStatus {
        let status = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .notDetermined:    return .notDetermined
        case .restricted:       return .disabled
        @unknown default:       return .invalid
        }
    }
    
    static func requestPermission(_ closure: @escaping (PermissionStatus) -> ()) {
        guard status == .notDetermined else {
            closure(status)
            return
        }
        CNContactStore().requestAccess(for: .contacts) { (_, _) in
            closure(status)
        }
    }

}
