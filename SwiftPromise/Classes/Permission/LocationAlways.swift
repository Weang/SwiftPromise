//
//  LocationAlways.swift
//  SwiftPromise_Example
//
//  Created by Mr.Wang on 2020/1/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import CoreLocation

class LocationAlways: Permission {
    
    static var locationDelegate: LocationDelegate?
    
    static var status: PermissionStatus {
        guard CLLocationManager.locationServicesEnabled() else {
            return .disabled
        }
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            return .notDetermined
        case .restricted:
            return .disabled
        case .authorizedAlways, .denied:
            return .denied
        case .authorizedWhenInUse:
            return .authorized
        @unknown default:
            return .invalid
        }
    }
    
    static func requestPermission(_ closure: @escaping (PermissionStatus) -> ()) {
        locationDelegate = LocationDelegate.init(didChangeAuthorization: { _ in
            closure(status)
        })
        locationDelegate?.requestWhenInUseAuthorization()
    }
    
}
