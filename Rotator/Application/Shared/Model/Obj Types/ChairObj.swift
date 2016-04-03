//
//  ChairObj.swift
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import Foundation
import UIKit

@objc class ChairObj: BaseObj {
    
    override init() {
        super.init()
        
        if let url = NSBundle.mainBundle().URLForResource("small_chair_close2", withExtension: "obj") {
            self.fileURL = url
        }
        self.viewSpace = ViewSpace(cameraDistance: -100, cameraNear: 0.1, cameraFar: 200)
    
    }
    
}