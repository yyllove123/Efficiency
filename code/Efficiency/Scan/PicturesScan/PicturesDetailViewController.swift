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
    
    var runloopTasks: [Any] = []
    var runloopMaxTasksNumber: Int = 10
    var runloopBlock: (() -> Void)?
    var runloopTimer: Timer?
    
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        print("123")
//        self.runloopTimer?.invalidate()
    }
    
    convenience init(folder: FolderModel) {
        self.init(nibName: "PicturesDetailViewController", bundle: nil)
        self.viewModel = PictureDetailViewModel(folder: folder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = viewModel?.name
        
        let cellNib = UINib(nibName: "PicDetailCell", bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: "PicDetailCell")
        
        self.runloopTimer = Timer(timeInterval: 0.001, target: self, selector: #selector(PicturesDetailViewController.runloopCall), userInfo: nil, repeats: true)
//        RunLoop.current.add(self.runloopTimer!, forMode: RunLoopMode.commonModes)
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel!.contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PicDetailCell", for: indexPath) as! PicDetailCell
        
        addTasks(cell: cell, picPath: viewModel!.contents[indexPath.row].path)
        
//        cell.picPath = viewModel!.contents[indexPath.row].path
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel!.contents[indexPath.row].height
    }
}

extension PicturesDetailViewController {
    
    @objc func runloopCall() {
        print("111");
    }
    
    func addTasks(cell: PicDetailCell, picPath: String?) {
        
        self.runloopTasks.append({
            if let image = UIImage(contentsOfFile: picPath!) {
                cell.setPicImage(image: image)
            }
        })

        if runloopTasks.count > runloopMaxTasksNumber {
            runloopTasks.remove(at: 0)
        }
    }
}
