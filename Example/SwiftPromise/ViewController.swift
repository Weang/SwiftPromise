//
//  ViewController.swift
//  SwiftPromise
//
//  Created by w704444178@qq.com on 01/14/2020.
//  Copyright (c) 2020 w704444178@qq.com. All rights reserved.
//

import UIKit
import SwiftPromise

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        PermissionProvider.request(.notification) {
            
        } failure: {
            
        }
    }

}

