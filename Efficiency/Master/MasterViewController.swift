//
//  MasterViewController.swift
//  Efficiency
//
//  Created by Yalin on 16/3/29.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController , UISplitViewControllerDelegate{

    var viewModel: MasterViewModel = MasterViewModel()
    var showDetail = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Efficiency";
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Split view
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        
        if showDetail {
            
            showDetail = false
            return false
        }
        
        return true
    }

    // MARK: - Table View
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.controllers.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let object = viewModel.controllers[indexPath.row] 
        cell.textLabel!.text = object.title
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controllerData = viewModel.controllers[indexPath.row]
        
        showDetail = true
        self.showDetailViewController(controllerData.controller, sender: nil)
    }
}

