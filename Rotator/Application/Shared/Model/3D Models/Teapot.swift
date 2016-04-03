//
//  Teapot.swift
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import Foundation
import UIKit

@objc class Teapot: ThreeDModel {
    
    override init() {
        super.init()
        
        if let url = NSBundle.mainBundle().URLForResource("teapot", withExtension: "obj") {
            self.fileURL = url
        }
        self.viewSpace = ViewSpace(cameraDistance: -1, cameraNear: 0.1, cameraFar: 100)
    }
    
}