//
//  BaseObjRenderer.swift
//  Rotator
//  
//  A facade wrapper for the C++ OBJRenderer, ensures BaseObj type is strict
//  Composition of OBJRenderer
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import UIKit

class Renderer {

    var baseObj: BaseObj? {
        didSet {
            if let baseObj = baseObj {
                
                // Setter ensures type is checked
                self.objRenderer.loadModel(baseObj)
            }
        }
    }
    
    // Expose for rotation of rotateable object
    var angularVelocity: CGPoint? {
        didSet {
            if let angularVelocity = angularVelocity {
                self.objRenderer.angularVelocity = angularVelocity
            }
        }
    }
    
    // Composition
    let objRenderer: OBJRenderer!
    
    init(metalView: MetalView!) {
        self.objRenderer = OBJRenderer(metalView: metalView)
    }
    
    func start() {
        objRenderer.start()
    }
    
    func stop() {
        objRenderer.stop()
    }
    
}
