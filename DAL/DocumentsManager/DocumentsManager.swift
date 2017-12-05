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
    
    class func queryAllFolderDatas(documentType: DocumentFolderType) -> [FolderModel] {
        // 本地所有图片的文件夹都以“pic_”开头
        
        var folders: [FolderModel] = []
        
        let documentsPath = NSHomeDirectory() + "/Documents"
        let contents = try! FileManager.default.contentsOfDirectory(atPath: documentsPath)
        
        for name in contents {
            if name.hasPrefix(documentType.prefixStr()) {
                folders.append(FolderModel(path: documentsPath + "/" + name, name: (name as NSString).replacingOccurrences(of: documentType.prefixStr(), with: ""), type: documentType))
            }
        }
        
        return folders
    }
    
    @discardableResult
    class func createDocumentFolder(documentType: DocumentFolderType, name: String) -> FolderModel {
        let folderPath = NSHomeDirectory() + "/Documents/\(documentType.prefixStr())\(name)"
        try! FileManager.default.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
        return FolderModel(path: folderPath, name: name, type: documentType)
    }
}
