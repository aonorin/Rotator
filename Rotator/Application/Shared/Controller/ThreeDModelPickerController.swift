//
//  ThreeDModelPickerController.swift
//  Rotator
//
//  Created by Dan on 3/4/16.
//  Copyright © 2016 DanArielPoblete. All rights reserved.
//

import UIKit
import URLNavigator

protocol ThreeDModelPickerControllerDelegate: class {
    func didPickModel(model: ThreeDModel)
}

class ThreeDModelPickerController: UITableViewController, URLNavigable {

    static let reuseIdentifier = "kCellReuseIdentifier"
    
    let models: [ThreeDModel] = ThreeDModelManager.sharedManager.models
    var selectedModel: ThreeDModel?
    
    weak var delegate: ThreeDModelPickerControllerDelegate?
    
    
    init(model: String) {
        if let model = ThreeDModelManager.sharedManager.modelForName(model) {
            self.selectedModel = model
        }
        
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
    
    private func setup() {
     
        self.title = "Select a model"
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: Selector("cancelButtonClicked:"))
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: ThreeDModelPickerController.reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ThreeDModelPickerController.reuseIdentifier, forIndexPath: indexPath)

        configureCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        
        let model = models[indexPath.row]
        
        cell.textLabel?.text = model.label
        
        if let selectedModel = selectedModel where selectedModel == model {
            cell.accessoryType = .Checkmark
        }
        else {
            cell.accessoryType = .None
        }
    }

    // MARK: Table view delegate
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let delegate = delegate {
            let model = models[indexPath.row]
            self.selectedModel = model
            
            delegate.didPickModel(model)
            self.navigateOut()
        }
        
    }
    
    
    // MARK: Action
    func cancelButtonClicked(sender: AnyObject) {
        navigateOut()
    }
    
    // MARK: Navigation
    func navigateOut() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
