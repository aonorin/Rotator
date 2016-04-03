//
//  ThreeDModelManager.swift
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import Foundation

class ThreeDModelManager {
    
    // Singleton works fine for a very small project like this
    // Use a dependency injection container for larger ones
    static let sharedManager = ThreeDModelManager()
    
    private let modelsMap: [String: ThreeDModel]
    
    var models: [ThreeDModel] {
        return Array(modelsMap.values)
    }
    
    init() {
        
        let models = [
            ThreeDModel(build: {
                $0.label = "Chair"
                $0.type = "chair"
                $0.fileURL = NSBundle.mainBundle().URLForResource("chair", withExtension: "obj")!
                $0.viewSpace = ViewSpace(cameraDistance: -100, cameraNear: 0.1, cameraFar: 200)
            }),
            ThreeDModel(build: {
                $0.label = "Teapot"
                $0.type = "teapot"
                $0.fileURL = NSBundle.mainBundle().URLForResource("teapot", withExtension: "obj")!
                $0.viewSpace = ViewSpace(cameraDistance: -1, cameraNear: 0.1, cameraFar: 100)
            }),
            ThreeDModel(build: {
                $0.label = "Teddy bear"
                $0.type = "teddy"
                $0.fileURL = NSBundle.mainBundle().URLForResource("teddy", withExtension: "obj")!
                $0.viewSpace = ViewSpace(cameraDistance: -50, cameraNear: 0.1, cameraFar: 200)
            }),
            ThreeDModel(build: {
                $0.label = "Cow"
                $0.type = "cow"
                $0.fileURL = NSBundle.mainBundle().URLForResource("cow", withExtension: "obj")!
                $0.viewSpace = ViewSpace(cameraDistance: -100, cameraNear: 0.1, cameraFar: 500)
            }),
            ThreeDModel(build: {
                $0.label = "Pitcher"
                $0.type = "pitcher"
                $0.fileURL = NSBundle.mainBundle().URLForResource("pitcher", withExtension: "obj")!
                $0.viewSpace = ViewSpace(cameraDistance: -100, cameraNear: 0.1, cameraFar: 300)
            }),
            
        ]
        
        var map: [String: ThreeDModel] = [:]
        for model in models {
            map[model.type] = model
        }
        
        self.modelsMap = map
    }
    
    func modelForName(name: String) -> ThreeDModel? {
        return modelsMap[name]
    }
}