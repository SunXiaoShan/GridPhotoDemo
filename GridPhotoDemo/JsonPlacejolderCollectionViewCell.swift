//
//  JsonPlacejolderCollectionViewCell.swift
//  GridPhotoDemo
//
//  Created by Phineas.Huang on 2019/9/19.
//  Copyright © 2019 Phineas. All rights reserved.
//

import UIKit

class JsonPlacejolderCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    class CellData {
        var data:JsonPlaceholderData?
        @objc dynamic var image: UIImage?
        
        init(data:JsonPlaceholderData) {
            self.data = data
        }
    }
    
    var cellData:CellData?
    let manager:JsonPlaceholderManager = JsonPlaceholderManager()

    func updateData(data:JsonPlaceholderData) {
        self.cellData = CellData(data:data)
        self.idLabel?.text = "\(data.id)"
        self.titleLabel?.text = data.title
        self.backgroundColor = UIColor.red
        
//        if let url = data.thumbnailUrl {
//            manager.downloadThumbnail(url: url, image:{result  in
//                guard "success" == result["result"] as? String else {
//                    self.backgroundColor = UIColor.green
//                    return
//                }
//                
//                if (self.cellData?.data?.thumbnailUrl == result["url"] as? String) {
//                    self.imageView.image = result["image"] as? UIImage
//                }
//            })
//        }
    }
}
