//
//  FolderModel.swift
//  Efficiency
//
//  Created by Yalin on 16/3/30.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

struct FolderModel {
    var name: String
    var path: String
    var date: NSDate
    
    init(path: String, name: String) {
        self.name = name;
        self.path = path
        
        let atts = try! NSFileManager.defaultManager().attributesOfItemAtPath(path);
        self.date = atts[NSFileModificationDate] as! NSDate
    }
}
