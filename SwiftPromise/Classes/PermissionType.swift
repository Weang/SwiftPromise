//
//  PermissionType.swift
//  permission
//
//  Created by Mr.wang on 2018/12/10.
//  Copyright © 2018 Mr.wang. All rights reserved.
//
import Foundation

public enum PermissionType {
    case microphone
    case photoLibrary
    case camera
    case contacts
    case locationInUse
    case locationAlways
}

extension PermissionType {
    
    public var infoDescription: String {
        switch self {
        case .microphone: return "NSMicrophoneUsageDescription"
        case .photoLibrary: return "NSPhotoLibraryUsageDescription"
        case .camera: return "NSCameraUsageDescription"
        case .contacts: return "NSContactsUsageDescription"
        case .locationInUse: return "NSLocationWhenInUseUsageDescription"
        case .locationAlways: return "NSLocationAlwaysAndWhenInUseUsageDescription"
        }
    }
    
    public var displayText: String {
        switch self {
        case .microphone: return "麦克风"
        case .photoLibrary: return "相册"
        case .camera: return "相机"
        case .contacts: return "通讯录"
        case .locationInUse: return "定位"
        case .locationAlways: return "定位"
        }
    }
    
    public var permission: Permission.Type {
        switch self {
        case .camera: return Camera.self
        case .photoLibrary: return PhotoLibrary.self
        case .microphone: return Microphone.self
        case .contacts: return Contacts.self
        case .locationInUse: return LocationInUse.self
        case .locationAlways: return LocationAlways.self
        }
    }
    
}
