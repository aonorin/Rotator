//
//  OBJRenderer.h
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Renderer.h"
#import "MetalView.h"

@interface OBJRenderer : NSObject

@property (nonatomic, assign) CGPoint angularVelocity;

- (instancetype)initWithMetalView:(MetalView *)metalView;

- (void)start;
- (void)stop;
- (void)loadModel:(id)obj;

@end
