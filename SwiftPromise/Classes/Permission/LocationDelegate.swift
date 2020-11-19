//
//  LocationDelegate.swift
//  SwiftPromise_Example
//
//  Created by Mr.Wang on 2020/1/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import CoreLocation

class LocationDelegate: NSObject, CLLocationManagerDelegate {
    
    let manager = CLLocationManager()
    let didChangeAuthorization: (CLAuthorizationStatus) -> ()
    
    init(didChangeAuthorization: @escaping (CLAuthorizationStatus) -> ()) {
        self.didChangeAuthorization = didChangeAuthorization
        super.init()
        
        manager.delegate = self
    }
    
    func requestWhenInUseAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    func requestAlwaysAuthorization() {
        manager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        didChangeAuthorization(status)
    }
    
    deinit {
        manager.delegate = nil
    }
    
}
