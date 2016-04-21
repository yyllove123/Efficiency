//
//  MasterViewModel.swift
//  Efficiency
//
//  Created by Yalin on 16/3/30.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import Foundation
import UIKit

struct MasterViewModel {
    var controllers: [FunctionData] = [
        FunctionData(controller: UINavigationController(rootViewController:PicturesScanViewController()), title: "图片浏览", detailInfo: nil),
        FunctionData(controller: UINavigationController(rootViewController:MovieListController()), title: "视频浏览", detailInfo: nil),
        FunctionData(controller: UINavigationController(rootViewController:BookScanController()), title: "图书浏览", detailInfo: nil)
    ]
}

struct FunctionData {
    var controller: UIViewController
    var title: String
    var detailInfo: String? = "功能介绍"
    
}