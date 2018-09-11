//
//  UIImageView.swift
//  youtube
//
//  Created by Sherif  Wagih on 9/7/18.
//  Copyright © 2018 Sherif  Wagih. All rights reserved.
//

import UIKit
let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView
{
    var imageUrlString:String?
    func loadImageUsingUrlString(imageName:String)
    {
        image = nil
        imageUrlString = imageName
        if let url = URL(string: imageName)
        {
            
            if let imageFromCache = imageCache.object(forKey: imageName as AnyObject) as? UIImage
            {
                print("Loading Cached image")
                self.image = imageFromCache
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil
                {
                    return
                }
                print("Download from server")
                DispatchQueue.main.async {
                    let imageToCache = UIImage(data: data!)
                    if self.imageUrlString == imageName
                    {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache!, forKey: imageName as AnyObject)

                }
                
                }.resume()
        }
    }
}
