//
//  PicturesScanViewController.swift
//  Efficiency
//
//  Created by Yalin on 16/3/30.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

class PicturesScanViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    var viewModel = PicturesScanViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    convenience init() {
        self.init(nibName: "PicturesScanViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "图片浏览"
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "PicturesScanCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PicturesScanCell", forIndexPath: indexPath)
        
        let object = viewModel.datas[indexPath.row]
        cell.textLabel!.text = object.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let object = viewModel.datas[indexPath.row]
        self.navigationController?.pushViewController(PicturesDetailViewController(folder: object), animated: true)
    }
}
