//
//  MovieListViewModel.swift
//  Efficiency
//
//  Created by Yalin on 16/4/13.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import Foundation

struct MovieListViewModel {
    var datas: [FolderModel] = DocumentsManager.queryAllFolderDatas(.Movie)
    
    mutating func refreshDatas() {
        self.datas = DocumentsManager.queryAllFolderDatas(.Movie)
    }
}