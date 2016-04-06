//
//  DocumentsManager.swift
//  Efficiency
//
//  Created by Yalin on 16/3/30.
//  Copyright © 2016年 Yalin. All rights reserved.
//

// http://www.jianshu.com/p/d6fe1e7af9b6

import UIKit

class DocumentsManager: NSObject {
    
    class func queryAllPicFolderDatas() -> [FolderModel] {
        // 本地所有图片的文件夹都以“pic_”开头
        
        var folders: [FolderModel] = []
        
        let documentsPath = NSHomeDirectory() + "/Documents"
        let contents = try! NSFileManager.defaultManager().contentsOfDirectoryAtPath(documentsPath)
        
        for name in contents {
            if name.hasPrefix("pic_") {
                folders.append(FolderModel(path: documentsPath + "/" + name, name: (name as NSString).stringByReplacingOccurrencesOfString("pic_", withString: "")))
            }
        }
        
        return folders
    }
    
    class func createFolder(name: String) -> FolderModel{
        let folderPath = NSHomeDirectory() + "/Documents/" + "pic_\(name)"
        
       try! NSFileManager.defaultManager().createDirectoryAtPath(folderPath, withIntermediateDirectories: true, attributes: nil)
        
        return FolderModel(path: folderPath, name: name)
    }
}
