//
//  Microphone.swift
//  permission
//
//  Created by Mr.wang on 2018/12/10.
//  Copyright © 2018 Mr.wang. All rights reserved.
//

import AVFoundation

class Microphone: Permission {
    
    static var status: PermissionStatus {
        let status = AVAudioSession.sharedInstance().recordPermission
        switch status {
        case .undetermined: return .notDetermined
        case .denied: return .denied
        case .granted: return .authorized
        @unknown default: return .invalid
        }
    }
    
    static func requestPermission(_ closure: @escaping (PermissionStatus) -> ()) {
        guard status == .notDetermined else {
            closure(status)
            return
        }
        AVAudioSession.sharedInstance().requestRecordPermission { _ in
            closure(status)
        }
    }
}
