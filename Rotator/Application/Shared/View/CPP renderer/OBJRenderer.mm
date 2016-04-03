//
//  ObjViewRenderer.m
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

#import "OBJRenderer.h"
#import "OBJModel.h"
#import "Shared.h"
#import "Transforms.h"
#import "MetalView.h"
#import "Rotator-Swift.h"

static const float kDamping = 0.05;

static float DegToRad(float deg)
{
    return deg * (M_PI / 180);
}

@interface OBJRenderer ()

@property (nonatomic, strong) ThreeDModel *obj;

@property (nonatomic, strong) Renderer *renderer;
@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) MetalView *view;
@property (nonatomic, assign) NSTimeInterval lastFrameTime;
@property (nonatomic, assign) CGPoint angle;

@property (nonatomic, strong) id<MTLBuffer> vertexBuffer;
@property (nonatomic, strong) id<MTLBuffer> indexBuffer;
@property (nonatomic, strong) id<MTLBuffer> uniformBuffer;

@property (nonatomic, assign) simd::float4x4 projectionMatrix;

@end

@implementation OBJRenderer

- (instancetype)initWithMetalView:(MetalView *)metalView
{
    if ((self = [super init]))
    {
        self.view = metalView;
        
        self.renderer = [[Renderer alloc] initWithLayer:(CAMetalLayer *)self.view.layer];
        self.renderer.vertexFunctionName = @"vertex_main";
        self.renderer.fragmentFunctionName = @"fragment_main";
        
        self.lastFrameTime = CFAbsoluteTimeGetCurrent();
    }
    
    return self;
}

- (void)loadModel:(id)obj {

    ThreeDModel *threeDModel = (ThreeDModel *)obj;

    self.obj = threeDModel;
    
    NSURL *modelURL = threeDModel.fileURL;
    
    OBJModel *model = [[OBJModel alloc] initWithContentsOfURL:modelURL];
    
    OBJGroup *baseGroup = [model groupAtIndex:1];
    if (baseGroup)
    {
        self.vertexBuffer = [self.renderer newBufferWithBytes:baseGroup->vertices
                                                       length:sizeof(Vertex) * baseGroup->vertexCount];
        self.indexBuffer = [self.renderer newBufferWithBytes:baseGroup->indices
                                                      length:sizeof(IndexType) * baseGroup->indexCount];
    }

}

- (void)start
{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkDidFire:)];
    [self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)stop
{
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)displayLinkDidFire:(CADisplayLink *)displayLink
{
    [self redraw];
}

- (void)updateMotion
{
    NSTimeInterval frameTime = CFAbsoluteTimeGetCurrent();
    NSTimeInterval frameDuration = frameTime - self.lastFrameTime;
    self.lastFrameTime = frameTime;
    
    if (frameDuration > 0)
    {
        self.angle = CGPointMake(self.angle.x + self.angularVelocity.x * frameDuration,
                                 self.angle.y + self.angularVelocity.y * frameDuration);
        
        self.angularVelocity = CGPointMake(self.angularVelocity.x * (1 - kDamping),
                                           self.angularVelocity.y * (1 - kDamping));
    }
}

- (void)updateUniforms
{
    static const simd::float3 X_AXIS = { 1, 0, 0 };
    static const simd::float3 Y_AXIS = { 0, 1, 0 };
    simd::float4x4 modelMatrix = Identity();
    modelMatrix = Rotation(Y_AXIS, -self.angle.x) * modelMatrix;
    modelMatrix = Rotation(X_AXIS, -self.angle.y) * modelMatrix;
    
    NSInteger cameraDistance = self.obj.viewSpace.cameraDistance;
    
    simd::float4x4 viewMatrix = Identity();
    viewMatrix.columns[3].z = cameraDistance; // translate camera back along Z axis
    
    float near = self.obj.viewSpace.cameraNear;
    float far = self.obj.viewSpace.cameraFar;
    
    const float aspect = self.view.bounds.size.width / self.view.bounds.size.height;
    simd::float4x4 projectionMatrix = PerspectiveProjection(aspect, DegToRad(75), near, far);
    
    Uniforms uniforms;
    
    simd::float4x4 modelView = viewMatrix * modelMatrix;
    uniforms.modelViewMatrix = modelView;
    
    simd::float4x4 modelViewProj = projectionMatrix * modelView;
    uniforms.modelViewProjectionMatrix = modelViewProj;
    
    simd::float3x3 normalMatrix = { modelView.columns[0].xyz, modelView.columns[1].xyz, modelView.columns[2].xyz };
    uniforms.normalMatrix = simd::transpose(simd::inverse(normalMatrix));
    
    self.uniformBuffer = [self.renderer newBufferWithBytes:(void *)&uniforms length:sizeof(Uniforms)];
}

- (void)redraw
{
    [self updateMotion];
    [self updateUniforms];
    
    [self.renderer startFrame];
    
    [self.renderer drawTrianglesWithInterleavedBuffer:self.vertexBuffer
                                          indexBuffer:self.indexBuffer
                                        uniformBuffer:self.uniformBuffer
                                           indexCount:[self.indexBuffer length] / sizeof(IndexType)];
    
    [self.renderer endFrame];
}

@end
