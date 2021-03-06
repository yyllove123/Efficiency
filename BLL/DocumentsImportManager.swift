//
//  DocumentsImportManager.swift
//  Efficiency
//
//  Created by Yalin on 16/4/6.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

class DocumentsImportManager: NSObject {
    class func applicationOpenURL(url: NSURL, options: [String : AnyObject]) -> Bool {
        let annotation = options[UIApplicationOpenURLOptionsAnnotationKey]
        let sourceApplication = options[UIApplicationOpenURLOptionsSourceApplicationKey]
        let openInPlace = options[UIApplicationOpenURLOptionsOpenInPlaceKey]
        
        print(" url: \(url)\n annotation: \(annotation)\n sourceApplication: \(sourceApplication) \n openInPlace: \(openInPlace)")
        
        if url.fileURL {
            if url.lastPathComponent!.hasSuffix("jpg") ||
                url.lastPathComponent!.hasSuffix("png")  {
                let controller = SelectFolderController.createWithComplete({ (folder) in
                    DocumentsImportManager.saveFileURLToFolder(folder, fileURL: url)
                })
                
                AppDelegate.changeToViewController(controller)
            }
        }
        
        return true
    }
    
    class func saveFileURLToFolder(folder: FolderModel, fileURL: NSURL) {
        
        let newFilePath = folder.path + "/" + fileURL.lastPathComponent!
        
        do {
            try NSFileManager.defaultManager().moveItemAtURL(fileURL, toURL: NSURL(fileURLWithPath: newFilePath))
        }catch let error as NSError {
            NSLog("保存文件失败 :%@", error.localizedDescription)
        }
    }
}
