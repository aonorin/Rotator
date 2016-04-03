//
//  ThreeDModel.swift
//  Rotator
//
//  Supposed Abstract class, but Swift doesn't have abstract classes so use protocols instead
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import Foundation

@objc class ThreeDModel: NSObject, Rotateable, OBJLoadable {
    
    var fileURL: NSURL = NSURL(string: "")!
    var viewSpace: ViewSpace = ViewSpace(cameraDistance: 0, cameraNear: 0, cameraFar: 0)
    var label: String = ""
    var type: String = ""
    
    // uses Builder pattern
    init(build: (ThreeDModel) -> Void) {
        super.init()
        build(self)
        
    }
    
}