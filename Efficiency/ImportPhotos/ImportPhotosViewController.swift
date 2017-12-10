//
//  ImportPhotosViewController.swift
//  Efficiency
//
//  Created by Yalin on 16/6/27.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit
import Photos
import PhotosUI

class ImportPhotosViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let cellWidth = UIScreen.main.bounds.size.width / 3
        collectionViewFlowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        let collections = PHAssetCollection.fetchAssetCollections(with: PHAssetCollectionType.album, subtype: PHAssetCollectionSubtype.any, options: nil)
        
//        collections.enumerateObjects { (asset: PHAssetCollection, index: Int, b: UnsafeMutablePointer<ObjCBool>) in
//            
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
