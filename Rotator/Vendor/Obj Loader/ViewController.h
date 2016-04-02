//
//  ViewController.h
//  UpAndRunning3D
//
//  Created by Warren Moore on 8/27/14.
//  Copyright (c) 2014 Metal By Example. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Renderer.h"

@interface ViewController : UIViewController

@property (nonatomic, strong) Renderer *renderer;
@property (nonatomic, strong) CADisplayLink *displayLink;

@end

