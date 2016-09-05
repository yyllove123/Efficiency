//
//  PicDetailCell.swift
//  Efficiency
//
//  Created by Yalin on 16/4/3.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

class PicDetailCell: UITableViewCell {
    
    var picPath: String? {
        didSet {
            
            let queue = DispatchQueue(label: "loadImage")
            
            queue.async { [unowned self] in
                if nil != self.picPath {
                    
                    if let image = UIImage(contentsOfFile: self.picPath!) {
                        
                        DispatchQueue.main.async { [unowned self] in
                            self.setPicImage(image: image)
                        }
                    }
                }
            }
        }
    }
    @IBOutlet weak var picImageView: UIImageView!

    func setPicImage(image: UIImage) {
        picImageView?.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
