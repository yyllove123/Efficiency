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
    
    var contents: [PicModel] = []
    
    init(folder: FolderModel) {
        
        name = folder.name
        
        // 读取所有图片
        var contents = try! NSFileManager.defaultManager().contentsOfDirectoryAtPath(folder.path)
        contents = contents.sort()
        
        for path in contents {
            
            if let picModel = PicModel(path: folder.path + "/" + path) {
                self.contents += [picModel]
            }
        }
    }
}


