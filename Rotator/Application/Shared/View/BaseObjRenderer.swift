//
//  BaseObjRenderer.swift
//  Rotator
//  
//  A wrapper for the C++ ObjViewRenderer, ensures BaseObj type is strict
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import UIKit

class BaseObjRenderer: ObjViewRenderer {

    var baseObj: BaseObj? {
        didSet {
            if let baseObj = baseObj {
                self.loadModel(baseObj)
            }
        }
    }
    
    override init!(metalView: MetalView!) {
        super.init(metalView: metalView)
    }
    
}
