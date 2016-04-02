//
//  URLNavigationMap.swift
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import Foundation
import URLNavigator

struct URLNavigationMap {
    
    static func initialize() {
        Navigator.map("rotatorapp://rotator/<int:id>", RotatorViewController.self)
    }
    
}