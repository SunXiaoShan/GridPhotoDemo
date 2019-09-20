//
//  JsonPlaceholderViewController.swift
//  GridPhotoDemo
//
//  Created by Phineas.Huang on 2019/9/19.
//  Copyright © 2019 Phineas. All rights reserved.
//

import UIKit

class JsonPlaceholderViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    let manager:JsonPlaceholderManager = JsonPlaceholderManager()
    var collectionViewListData:[JsonPlaceholderData]?
    var imagePool:[String : UIImage] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        // Do any additional setup after loading the view.
        manager.requestJsonPlaceholder { result in
            self.collectionViewListData = result
            self.collectionView.reloadData()
        }
    }

    func setupCollection() {
        let fullScreenSize :CGSize! = UIScreen.main.bounds.size
        let gap:CGFloat = 5
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: gap, left: gap, bottom: gap, right: gap)
        layout.minimumLineSpacing = gap
        layout.itemSize = CGSize(
            width: CGFloat(fullScreenSize.width)/4 - gap * 2,
            height: CGFloat(fullScreenSize.width)/4 - gap * 2)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.dataSource = self as UICollectionViewDataSource
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

}

extension JsonPlaceholderViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionViewListData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JsonPlacejolderCollectionViewCell", for: indexPath) as! JsonPlacejolderCollectionViewCell
        
        if let data = self.collectionViewListData?[indexPath.row] {
            cell.updateData(data: data)
            
            //test
            if let url = data.thumbnailUrl, !(self.imagePool[url] != nil) {
                manager.downloadThumbnail(url: url, image:{result  in
                    guard "success" == result["result"] as? String else {
                        return
                    }
                    
                    if (url == result["url"] as? String) {
                        self.imagePool[url] = result["image"] as! UIImage
                    }
                })
            }
            
            if let url = data.thumbnailUrl {
                cell.imageView.image = self.imagePool[url]
            }
            
        }

        return cell
    }
    
    
}
