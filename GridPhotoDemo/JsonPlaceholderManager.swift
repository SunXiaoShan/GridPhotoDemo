//
//  JsonPlaceholderManager.swift
//  GridPhotoDemo
//
//  Created by Phineas.Huang on 2019/9/19.
//  Copyright © 2019 Phineas. All rights reserved.
//

import UIKit
import Alamofire

struct JsonPlaceholderData:Codable {
    var albumId:Int
    var id:Int
    var thumbnailUrl:String?
    var title:String?
    var url:String?
}

class JsonPlaceholderManager: NSObject {
    static let queue = DispatchQueue(label: "com.JsonPlaceholderManager.queue")

    let url = "https://jsonplaceholder.typicode.com/photos"
    /*
     {
       "albumId": 1,
       "id": 4,
       "thumbnailUrl": "https://via.placeholder.com/150/d32776",
       "title": "culpa odio esse rerum omnis laboriosam voluptate repudiandae",
       "url": "https://via.placeholder.com/600/d32776"
     }
     */
    
    func requestJsonPlaceholder( api: @escaping ([JsonPlaceholderData]) -> Void ) {
        JsonPlaceholderManager.queue.async { [weak self] in
            guard let self = self else {
                return
            }

            Alamofire.request(self.url).responseJSON { response in
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                if let data = response.data, let result = try?
                    decoder.decode([JsonPlaceholderData].self, from: data) {
                    DispatchQueue.main.async {
                        api(result)
                    }
                }
            }
        }
    }
    
    func downloadThumbnail(url:String, image:@escaping ([String:Any]) -> Void ) {
        let url = url
        JsonPlaceholderManager.queue.async {
            Alamofire.request(url, method: .get)
            .validate()
            .responseData(completionHandler: { (responseData) in
                DispatchQueue.main.async {
                    guard responseData.result.isSuccess else {
                        let result:[String : Any] = [
                            "url": String(describing: responseData.request!),
                            "result": "failed"
                            ]

                        image(result)
                        return
                    }

                    let result:[String : Any] = [
                        "url": String(describing: responseData.request!),
                        "image": UIImage(data: responseData.data!)!,
                        "result": "success"
                        ]

                    image(result)
                }
            })

        }
    }
}
