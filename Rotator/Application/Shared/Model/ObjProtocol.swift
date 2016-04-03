//
//  ObjProtocol.swift
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import Foundation

@objc protocol ObjProtocol {
    
    var fileURL: NSURL { get set }
    var viewSpace: ViewSpace { get set }
    
}