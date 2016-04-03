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
            let screenScale = UIScreen.mainScreen().scale
            let newSize = PicModel.scaleHeightToTargetSize(image.size, targetSize: CGSizeMake(UIScreen .mainScreen().bounds.size.width, 10000))
            height = newSize.height
            
            if image.size.width > UIScreen.mainScreen().bounds.size.width * screenScale {
                let newImage = PicModel.scaleImageToTargetSize(image, targetSize: CGSizeMake(newSize.width * screenScale, newSize.height * screenScale))
                try! UIImageJPEGRepresentation(newImage, 1)?.writeToFile(path, options: NSDataWritingOptions.AtomicWrite)
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
        
        if CGSizeEqualToSize(originSize, targetSize) == false {
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
        
        return CGSizeMake(scaledWidth, scaledHeight)
    }
    
    static func scaleImageToTargetSize(image: UIImage, targetSize: CGSize) -> UIImage {
        // Create a graphics image context
        UIGraphicsBeginImageContext(targetSize);
        
        // Tell the old image to draw in this new context, with the desired new size
        image.drawInRect(CGRectMake(0, 0, targetSize.width, targetSize.height))
        
        // Get the new image from the context
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        // End the context
        UIGraphicsEndImageContext()
        
        return newImage
    }
}

/*
 - (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
 
 {
 
 // Create a graphics image context
 
 UIGraphicsBeginImageContext(newSize);
 
 
 
 // Tell the old image to draw in this new context, with the desired
 
 // new size
 
 [image drawInRect:CGRectMake(,,newSize.width,newSize.height)];
 
 
 
 // Get the new image from the context
 
 UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
 
 
 
 // End the context
 
 UIGraphicsEndImageContext();
 
 
 
 // Return the new image.
 
 return newImage;
 
 }
 */