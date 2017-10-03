//
//  ImageStore.swift
//  MoviesCollection
//
//  Created by chanakkya mati on 9/26/17.
//  Copyright © 2017 chanakya. All rights reserved.
//

import Foundation
import UIKit
class ImageStore {
    

    static private let session = {
       URLSession(configuration: URLSessionConfiguration.ephemeral)
    }()
    
    
    
    func pathfor(key:String) ->URL{
        let urls =  FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
        let documentUrl = urls.first!
        return documentUrl.appendingPathComponent(key)
    }
    
   private let cache = NSCache<NSString,UIImage>()
    func setImage(_ image:UIImage, forkey key:String){
        let url = pathfor(key: key)
        let data = UIImageJPEGRepresentation(image, 1.0)
        try? data?.write(to: url)
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(forkey key:String)->UIImage?{
        if let image = cache.object(forKey: key as NSString){
            return image
        }
        
        if let image = UIImage(contentsOfFile: pathfor(key: key).path){
            cache.setObject(image, forKey: key as NSString)
            return image
        }
        
        return nil
    }
    
    

}
