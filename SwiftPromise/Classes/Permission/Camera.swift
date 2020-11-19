//
//  Camera.swift
//  permission
//
//  Created by Mr.wang on 2018/12/10.
//  Copyright © 2018 Mr.wang. All rights reserved.
//

import AVFoundation

struct Camera: Permission {
    
    static var status: PermissionStatus {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
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
        AVCaptureDevice.requestAccess(for: .video) { _ in
            closure(self.status)
        }
    }
    
}
