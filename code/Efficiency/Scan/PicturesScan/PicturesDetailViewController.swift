//
//  PicturesDetailViewController.swift
//  Efficiency
//
//  Created by Yalin on 16/3/30.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit
import CoreFoundation

class PicturesDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var viewModel: PictureDetailViewModel?
    
    var runloopTasks: [Any] = []
    var runloopMaxTasksNumber: Int = 10
    var runloopBlock: (() -> Void)?
    var runloopTimer: Timer?
    
    let runloop = CFRunLoopGetCurrent()
    var runloopObserver: CFRunLoopObserver? = nil;
    
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
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PicFolderDetailCell")
        
//        self.runloopTimer = Timer(timeInterval: 0.001, target: self, selector: #selector(PicturesDetailViewController.runloopCall), userInfo: nil, repeats: true)
//        RunLoop.current.add(self.runloopTimer!, forMode: RunLoopMode.commonModes)
        
        addRunloopOberver1()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        CFRunLoopRemoveObserver(runloop, runloopObserver, CFRunLoopMode.commonModes)
        
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
        
        let model = viewModel!.contents[indexPath.row]
        if let picModel = model as? PicModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PicDetailCell", for: indexPath) as! PicDetailCell
            
            addTasks(cell: cell, picPath: picModel.path)
            return cell
        }
        else if let folderModel = model as? FolderModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PicFolderDetailCell", for: indexPath)
            cell.textLabel?.text = folderModel.name
            return cell
        }
        
        return UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let model = viewModel!.contents[indexPath.row]
        if let picModel = model as? PicModel {
            return picModel.height
        }
        
        return 55
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let model = viewModel!.contents[indexPath.row]
        if let folderModel = model as? FolderModel {
            self.navigationController?.pushViewController(PicturesDetailViewController(folder: folderModel), animated: true)
        }
    }
}

extension PicturesDetailViewController {
    
    func addRunloopOberver2() {
        
        // https://www.jianshu.com/p/cb2efe0957f4  参考这个地址 指针类型转换
        var blockSelf = self
        let controllerPoint = withUnsafeMutablePointer(to: &blockSelf) { return $0}
        
        var content = CFRunLoopObserverContext(version: 0, info: UnsafeMutableRawPointer(controllerPoint), retain: nil, release: nil, copyDescription: nil)
        
        self.runloopObserver = CFRunLoopObserverCreate(nil, CFRunLoopActivity.beforeWaiting.rawValue, true, 0, { (oberver, activity, info) in
            
            if info == nil {//如果没有取到  直接返回
                return
            }
            
            let controller = UnsafeMutableRawPointer(info)?.assumingMemoryBound(to: PicturesDetailViewController.self).pointee
            
            assert(false, "崩溃，这里按理说应该是可以的，我自己写了C方法传值试验成功，但是可能是由于CF框架里面有一些内存方面的处理，导致这里的方法不能使用，而且CF框架建议使用Unmanaged的方式转换指针")
            
            if (controller?.isKind(of: PicturesDetailViewController.self))! {
                controller?.runloopCall()
            }
            
            
        }, &content)
        
        CFRunLoopAddObserver(runloop, runloopObserver, CFRunLoopMode.commonModes)
    }
    
    func addRunloopOberver1() {
        
        // https://www.jianshu.com/p/cb2efe0957f4  参考这个地址 指针类型转换
        let controllerPoint = Unmanaged<PicturesDetailViewController>.passUnretained(self).toOpaque()
        
        var content = CFRunLoopObserverContext(version: 0, info: controllerPoint, retain: nil, release: nil, copyDescription: nil)
        
        runloopObserver = CFRunLoopObserverCreate(nil, CFRunLoopActivity.beforeWaiting.rawValue, true, 0, { (oberver, activity, info) in
            
            if info == nil {//如果没有取到  直接返回
                return
            }
            
            let controller = Unmanaged<PicturesDetailViewController>.fromOpaque(info!).takeUnretainedValue()
            
            
            if controller.isKind(of: PicturesDetailViewController.self) {
                controller.runloopCall()
            }
            
            
        }, &content)
        
        CFRunLoopAddObserver(runloop, runloopObserver, CFRunLoopMode.commonModes)
    }
    
    func addRunloopOberver() {
        
        // https://www.jianshu.com/p/cb2efe0957f4  参考这个地址 指针类型转换
        let controllerPoint = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
        
        var content = CFRunLoopObserverContext(version: 0, info: controllerPoint, retain: nil, release: nil, copyDescription: nil)
        
        runloopObserver = CFRunLoopObserverCreate(nil, CFRunLoopActivity.beforeWaiting.rawValue, true, 0, { (oberver, activity, info) in
            
            if info == nil {//如果没有取到  直接返回
                return
            }
            
            let controller = unsafeBitCast(info, to: PicturesDetailViewController.self)
            
            if controller.isKind(of: PicturesDetailViewController.self) {
                controller.runloopCall()
            }
            
            
        }, &content)
        
        CFRunLoopAddObserver(runloop, runloopObserver, CFRunLoopMode.commonModes)
        //   gxx      CFRelease(runloopObserver)
    }
    
    @objc func runloopCall() {
        
        if runloopTasks.count == 0 {
            return;
        }
        
        if let task = runloopTasks.first as? ()->Void {
            task()
            runloopTasks.removeFirst()
        }
        
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

