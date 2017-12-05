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
    var complete: ((_ folder: FolderModel) -> Void)?

    @IBOutlet weak var tableView: UITableView!
    
    class func createWithComplete(complete: @escaping (_ folder: FolderModel) -> Void) -> UINavigationController {
        let controller = SelectFolderController()
        controller.complete = complete
        
        let naviController = UINavigationController(rootViewController: controller)
        
        return naviController
    }
    
    convenience init() {
        self.init(nibName: "SelectFolderController", bundle: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.refreshDatas()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel.refreshDatas()
        
        self.title = "选择目录"
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SelectFolderCell")
        
        let closeItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.plain, target: self, action: #selector(SelectFolderController.closeItemPressed))
        self.navigationItem.leftBarButtonItem = closeItem
        
        let addFolderItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(SelectFolderController.addFolderItemPressed))
        self.navigationItem.rightBarButtonItem = addFolderItem
        
        let segmentedControl = UISegmentedControl(items: ["图片", "视频", "图书"])
        segmentedControl.addTarget(self, action: #selector(SelectFolderController.categoryChange(control:)), for: .valueChanged)
        self.navigationItem.titleView = segmentedControl
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Method Response
    @objc func closeItemPressed() {
        AppDelegate.changeToViewController(controller: LockManager.lockController())
//        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @objc func addFolderItemPressed() {
        
        
        let alertController = UIAlertController(title: "创建文件夹", message: "输入文件夹名", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addTextField { (textField: UITextField) in
            
        }
        
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { [unowned self] (action: UIAlertAction) in
            
            if let text = alertController.textFields?.first?.text{
                DocumentsManager.createDocumentFolder(documentType: DocumentFolderType.Pic, name: text)
                self.viewModel.refreshDatas()
                self.tableView.reloadData()
            }
            else {
                Alert.showErrorAlert(title: "文件名不能为空", message: nil)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func categoryChange(control: UISegmentedControl) {
        if control.selectedSegmentIndex == 0 {
            viewModel.type = .Pic
        }
        else if control.selectedSegmentIndex == 1 {
            viewModel.type = .Movie
        }
        else if control.selectedSegmentIndex == 2 {
            viewModel.type = DocumentFolderType.Book
        }
        
        self.viewModel.refreshDatas()
        self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectFolderCell", for: indexPath as IndexPath)
        
        let object = viewModel.datas[indexPath.row]
        cell.textLabel!.text = object.name
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let object = viewModel.datas[indexPath.row]
//        self.navigationController?.pushViewController(PicturesDetailViewController(folder: object), animated: true)
        complete?(object)
        
        AppDelegate.changeToViewController(controller: LockManager.lockController())
//        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
