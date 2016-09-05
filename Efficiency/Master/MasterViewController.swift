//
//  MasterViewController.swift
//  Efficiency
//
//  Created by Yalin on 16/3/29.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit
import PhotosUI

class MasterViewController: UITableViewController , UISplitViewControllerDelegate{

    var viewModel: MasterViewModel = MasterViewModel()
    var showDetail = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = "Efficiency";
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(MasterViewController.addItemPressed))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func viewWillAppear(_ animated: Bool) {
//        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Response Method
    func addItemPressed() {
//        let controller = PHContentEditingController()
//        
//        
//        self.presentViewController(controller, animated: true, completion: nil)
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.controllers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        
        let object = viewModel.controllers[indexPath.row]
        cell.textLabel!.text = object.title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controllerData = viewModel.controllers[indexPath.row]
        
        showDetail = true
        self.showDetailViewController(controllerData.controller, sender: nil)
    }
}

