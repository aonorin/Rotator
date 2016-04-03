//
//  ViewSpace.swift
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import Foundation

@objc class ViewSpace: NSObject {

    var cameraDistance: Int
    var cameraNear: Float
    var cameraFar: Float
    
    init(cameraDistance: Int, cameraNear: Float, cameraFar: Float) {
        self.cameraDistance = cameraDistance
        self.cameraNear = cameraNear
        self.cameraFar = cameraFar
    }
}