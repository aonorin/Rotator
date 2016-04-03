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
    
    var model: ThreeDModel {
        didSet {
            renderer.model = model
            loadModel(model)
        }
    }
    
    let modelPickerButton = UIButton(type: .System)
    
    
    init(model: String) {
        self.model = Chair()
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience required init?(URL: URLConvertible, values: [String : AnyObject]) {
        
        // Load model needed
        guard let model = values["model"] as? String else {
            return nil
        }
        
        self.init(model: model)
        
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
        
        // Setup swipe rotating event handler
        let gr = UIPanGestureRecognizer(target: self, action: Selector("didPanMetalView:"))
        self.metal.addGestureRecognizer(gr)
        
        // Load model
        loadModel(self.model)
        
        // Setup switcher
        modelPickerButton.addTarget(self, action: Selector("modelPickerButtonClicked:"), forControlEvents: .TouchUpInside)
        modelPickerButton.titleLabel?.font = .boldSystemFontOfSize(17.0)
        self.navigationItem.titleView = modelPickerButton
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
        // Allows XYZ axis rotation
        let velocity = gestureRecognizer.velocityInView(metal)
        renderer.angularVelocity = CGPoint(x: velocity.x * CGFloat(RotatorViewController.velocityScale), y: velocity.y * CGFloat(RotatorViewController.velocityScale))
    }
    
    // MARK: Navigation
    func navigateToModelPicker() {
        
        guard let modelPicker = Navigator.viewControllerForURL("rotatorapp://modelpicker/123") else {
            print("You may have missed out on setting the route for this... set it properly at URLNavigationMap")
            return
        }
        
        let nav = UINavigationController(rootViewController: modelPicker)
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    // MARK: Action
    func switchToTeapot() {
        renderer.model = Teapot()
    }
    
    func loadModel(model: ThreeDModel) {
        renderer.model = model
        modelPickerButton.setTitle("\(model.description) ▾", forState: .Normal)
    }
    
    func modelPickerButtonClicked(sender: AnyObject) {
        navigateToModelPicker()
    }
}
