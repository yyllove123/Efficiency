//
//  PicModel.swift
//  Efficiency
//
//  Created by Yalin on 16/4/3.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

struct PicModel {
    var path: String
    var height: CGFloat
    
    init?(path: String) {
        if let image = UIImage(contentsOfFile: path) {
            self.path = path
            let screenScale = UIScreen.main.scale
            
            
            let newSize = PicModel.scaleHeightToTargetSize(originSize: image.size, targetSize: CGSize(width: UIScreen.main.bounds.size.width, height: 10000))
            height = newSize.height
            
            if image.size.width > UIScreen.main.bounds.size.width * screenScale {
                
                let newImage = PicModel.scaleImageToTargetSize(image: image, targetSize: CGSize(width: newSize.width * screenScale, height: newSize.height * screenScale))
                
                
                try! UIImageJPEGRepresentation(newImage, 1)?.write(to: URL(fileURLWithPath: path), options: NSData.WritingOptions.atomicWrite)
//                try! (UIImageJPEGRepresentation(newImage, 1) as? NSData).write(toFile: path, options: NSData.WritingOptions.atomicWrite)
            }
        }
        else {
            return nil
        }
    }
    
    static func scaleHeightToTargetSize(originSize: CGSize ,targetSize: CGSize) -> CGSize {
        
        var scaleFactor: CGFloat = 0.0
        var scaledWidth = targetSize.width
        var scaledHeight = targetSize.height
        
        if originSize.equalTo(targetSize) == false {
            let widthFactor = targetSize.width / originSize.width
            let heightFactor = targetSize.height / originSize.height
            
            if widthFactor < heightFactor {
                scaleFactor = widthFactor
            }
            else {
                scaleFactor = heightFactor
            }
            scaledWidth = originSize.width * scaleFactor
            scaledHeight = originSize.height * scaleFactor
        }
        
        return CGSize(width: scaledWidth, height: scaledHeight)
    }
    
    static func scaleImageToTargetSize(image: UIImage, targetSize: CGSize) -> UIImage {
        // Create a graphics image context
        UIGraphicsBeginImageContext(targetSize);
        
        
        // Tell the old image to draw in this new context, with the desired new size
        image.draw(in: CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height))
        
        // Get the new image from the context
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
