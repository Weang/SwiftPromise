//
//  PhotoLibrary.swift
//  permission
//
//  Created by Mr.wang on 2018/12/10.
//  Copyright © 2018 Mr.wang. All rights reserved.
//

import Photos

struct PhotoLibrary: Permission {
    
    static var status: PermissionStatus {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:       return .authorized
        case .denied:           return .denied
        case .notDetermined:    return .notDetermined
        case .restricted:       return .disabled
        case .limited:          return .authorized
        @unknown default:       return .invalid
        }
    }
    
    static func requestPermission(_ closure: @escaping (PermissionStatus) -> ()) {
        guard status == .notDetermined else {
            closure(status)
            return
        }
        PHPhotoLibrary.requestAuthorization { _ in
            closure(status)
        }
    }
}
