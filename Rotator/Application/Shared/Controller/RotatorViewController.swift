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

    init(modelId: Int) {
        super.init(nibName: nil, bundle: nil)
    }
    
    convenience required init?(URL: URLConvertible, values: [String : AnyObject]) {
        
        // Let's assume that the user id is required
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
        
        // TODO: Move this to a theme manager
        self.view.backgroundColor = .whiteColor()
    }
    
    // MARK: Navigation
    func navigateToModelSelector() {
        
    }
}
