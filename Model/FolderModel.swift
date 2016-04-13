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
    var type: DocumentFolderType
    var date: NSDate
    
    init(path: String, name: String, type: DocumentFolderType) {
        self.name = name
        self.path = path
        self.type = type
        
        let atts = try! NSFileManager.defaultManager().attributesOfItemAtPath(path);
        self.date = atts[NSFileModificationDate] as! NSDate
    }
}

enum DocumentFolderType {
    case Pic
    case Movie
    case Book
    
    func prefixStr() -> String {
        switch self {
        case .Pic:
            return "pic_"
        case .Movie:
            return "movie_"
        case .Book:
            return "book_"
        }
    }
}
