//
//  BaseObj.swift
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import Foundation

@objc class BaseObj: NSObject, ObjProtocol {
    
    var fileURL: NSURL
    var viewSpace: ViewSpace
    
    override init() {
        self.fileURL = NSURL(string: "Lorem")!
        self.viewSpace = ViewSpace(cameraDistance: 0, cameraNear: 0, cameraFar: 0)
        super.init()
    }
    
}