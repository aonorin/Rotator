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

    lazy var metal: MetalView = {
        let metal = MetalView()
        self.view.addSubview(metal)
        return metal
    }()
    
    lazy var renderer: ObjViewRenderer = {
        let r = ObjViewRenderer(metalView: self.metal)
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
        
        // Setup metal
        
        renderer.loadModel(ChairObj())
//        renderer.loadModel(TeapotObj())
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
    
    
    // MARK: Navigation
    func navigateToModelSelector() {
        
        
    }
}
