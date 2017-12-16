//
//  BookScanViewModel.swift
//  Efficiency
//
//  Created by Yalin on 16/4/16.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

struct BookScanViewModel {
    var datas: [FolderModel] = DocumentsManager.queryAllFolderDatas(documentType: .Book)
    
    mutating func refreshDatas() {
        self.datas = DocumentsManager.queryAllFolderDatas(documentType: .Book)
    }
}
