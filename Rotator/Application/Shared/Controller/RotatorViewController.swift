//
//  RotatorViewController.swift
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import UIKit
import URLNavigator

class RotatorViewController: UIViewController, URLNavigable {

    static let velocityScale: Float = 0.01
    
    lazy var metal: MetalView = {
        let metal = MetalView()
        self.view.addSubview(metal)
        return metal
    }()
    
    lazy var renderer: Renderer = {
        let r = Renderer(metalView: self.metal)
        return r
    }()
    
    
    init(modelId: Int) {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience required init?(URL: URLConvertible, values: [String : AnyObject]) {
        
        // Load model needed
        guard let modelId = values["id"] as? Int else {
            return nil
        }
        
        self.init(modelId: modelId)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setup() {
        
        // Prevent view from going underneath nav bar
        self.edgesForExtendedLayout = .None
        self.navigationController?.view.backgroundColor = .whiteColor()
        
        // Renderer will display the rotateable object using metal
        renderer.model = Chair()
        
        // Setup swipe rotating event handler
        let gr = UIPanGestureRecognizer(target: self, action: Selector("didPanMetalView:"))
        self.metal.addGestureRecognizer(gr)
        
        // Setup switcher
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Teapot time", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("switchToTeapot"))
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        renderer.start()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    
        renderer.stop()
    }
    
    // MARK: Layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        metal.frame = self.view.bounds
    }
    
    // MARK: UIPanGestureRecognizer
    func didPanMetalView(gestureRecognizer: UIPanGestureRecognizer) {

        // Affects the angle of the rotateable object
        let velocity = gestureRecognizer.velocityInView(metal)
        renderer.angularVelocity = CGPoint(x: velocity.x * CGFloat(RotatorViewController.velocityScale), y: velocity.y * CGFloat(RotatorViewController.velocityScale))
    }
    
    // MARK: Navigation
    func navigateToModelSelector() {
        
        
    }
    
    // MARK: Action
    func switchToTeapot() {
        renderer.model = Teapot()
    }
}
