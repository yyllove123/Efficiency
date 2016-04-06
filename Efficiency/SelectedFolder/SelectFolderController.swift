//
//  SelectFolderController.swift
//  Efficiency
//
//  Created by Yalin on 16/4/6.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

class SelectFolderController: UIViewController, UIAlertViewDelegate {
    
    var viewModel = SelectFolderViewModel()
    var complete: ((folder: FolderModel) -> Void)?

    @IBOutlet weak var tableView: UITableView!
    
    class func createWithComplete(complete: (folder: FolderModel) -> Void) -> UINavigationController {
        let controller = SelectFolderController()
        controller.complete = complete
        
        let naviController = UINavigationController(rootViewController: controller)
        
        return naviController
    }
    
    convenience init() {
        self.init(nibName: "SelectFolderController", bundle: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.refreshDatas()
        
        self.title = "选择目录"
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SelectFolderCell")
        
        let closeItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(SelectFolderController.closeItemPressed))
        self.navigationItem.leftBarButtonItem = closeItem
        
        let addFolderItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(SelectFolderController.addFolderItemPressed))
        self.navigationItem.rightBarButtonItem = addFolderItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.refreshDatas()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Method Response
    func closeItemPressed() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addFolderItemPressed() {
        let alert = UIAlertView(title: "创建文件夹", message: "输入文件夹名", delegate: self, cancelButtonTitle: "取消" ,otherButtonTitles: "确定")
        alert.alertViewStyle = UIAlertViewStyle.PlainTextInput
        alert.show()
        
        
    }
    
    // MARK: - Alert Delegate
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 1 {
            if let text = alertView.textFieldAtIndex(0)?.text{
                DocumentsManager.createFolder(text)
                self.viewModel.refreshDatas()
                self.tableView.reloadData()
            }
            else {
                Alert.showErrorAlert("文件名不能为空", message: nil)
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - TableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SelectFolderCell", forIndexPath: indexPath)
        
        let object = viewModel.datas[indexPath.row]
        cell.textLabel!.text = object.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let object = viewModel.datas[indexPath.row]
//        self.navigationController?.pushViewController(PicturesDetailViewController(folder: object), animated: true)
        complete?(folder: object)
        
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
