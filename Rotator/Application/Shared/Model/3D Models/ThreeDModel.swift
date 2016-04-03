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
    
    var fileURL: NSURL
    var viewSpace: ViewSpace
    
    override init() {
        self.fileURL = NSURL(string: "")!
        self.viewSpace = ViewSpace(cameraDistance: 0, cameraNear: 0, cameraFar: 0)
        super.init()
    }
    
}