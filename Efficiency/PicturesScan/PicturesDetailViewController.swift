//
//  PicturesDetailViewController.swift
//  Efficiency
//
//  Created by Yalin on 16/3/30.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

class PicturesDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel: PictureDetailViewModel?
    
    @IBOutlet weak var tableView: UITableView!
    
    convenience init(folder: FolderModel) {
        self.init(nibName: "PicturesDetailViewController", bundle: nil)
        self.viewModel = PictureDetailViewModel(folder: folder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = viewModel?.name
        
        let cellNib = UINib(nibName: "PicDetailCell", bundle: nil)
        self.tableView.registerNib(cellNib, forCellReuseIdentifier: "PicDetailCell")
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

    // MARK: - TableView DataSource Delegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.contents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PicDetailCell", forIndexPath: indexPath) as! PicDetailCell
        
        cell.picPath = viewModel!.contents[indexPath.row].path
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return viewModel!.contents[indexPath.row].height
    }
}
