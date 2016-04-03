//
//  ObjView.swift
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import Foundation

class ObjView: MetalView {

    var obj: ObjProtocol {
        didSet {
            
        }
    }
    
    override convenience init(frame: CGRect) {
        self.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}