//
//  PictureDetailViewModel.swift
//  Efficiency
//
//  Created by Yalin on 16/3/30.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit
import CoreGraphics

struct PictureDetailViewModel {

    var name: String
    
    var contents: [Any] = []
    
    init(folder: FolderModel) {
        
        name = folder.name
        
        // 读取所有图片
        var contents = try! FileManager.default.contentsOfDirectory(atPath: folder.path)
        contents.sort()
        
        var folderModels: [FolderModel] = []
        var picModels: [PicModel] = []
        
        for path in contents {
            
            if path.contains(".") {
                if let picModel = PicModel(path: folder.path + "/" + path) {
                    picModels.append(picModel)
                }
            }
            else {
                let folderModel = FolderModel(path: folder.path + "/" + path, name: path, type: .Pic)
                folderModels.append(folderModel)
                
            }
        }
        
        for value in folderModels {
            self.contents.append(value)
        }
        
        for value in picModels {
            self.contents.append(value)
        }
    }
}


