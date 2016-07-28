//
//  PicturesScanViewModel.swift
//  Efficiency
//
//  Created by Yalin on 16/3/30.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import Foundation
import UIKit

struct PicturesScanViewModel {
    var datas: [FolderModel] = DocumentsManager.queryAllFolderDatas(documentType: .Pic)
    
    mutating func refreshDatas() {
        self.datas = DocumentsManager.queryAllFolderDatas(documentType: .Pic)
    }
}
