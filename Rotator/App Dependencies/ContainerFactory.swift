//
//  ContainerFactory.swift
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import Foundation
import Swinject

final class ContainerFactory {
    
    func build() -> Container {
        
        let container = Container()
        
        registerApplication(container)
        
        return container
    }
    
    
    // MARK: Layers
    private func registerApplication(container: Container) {
    
    }
}
