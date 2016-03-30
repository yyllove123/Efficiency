//
//  DocumentsManager.swift
//  Efficiency
//
//  Created by Yalin on 16/3/30.
//  Copyright © 2016年 Yalin. All rights reserved.
//

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
}
