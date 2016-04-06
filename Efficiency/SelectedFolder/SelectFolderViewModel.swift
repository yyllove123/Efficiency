//
//  SelectFolderViewModel.swift
//  Efficiency
//
//  Created by Yalin on 16/4/6.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

struct SelectFolderViewModel {
    
//    var type: String = "pic"
    
    var datas: [FolderModel] = DocumentsManager.queryAllPicFolderDatas()
    
    mutating func refreshDatas() {
        self.datas = DocumentsManager.queryAllPicFolderDatas()
    }
}
