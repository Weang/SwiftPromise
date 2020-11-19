//
//  PermissionAlert.swift
//  SwiftPromise_Example
//
//  Created by Mr.Wang on 2020/1/14.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

public protocol PermissionAlert {
    
    func showAlert(_ permission: PermissionType, status: PermissionStatus, cancelClosuer: @escaping () -> ())

}
