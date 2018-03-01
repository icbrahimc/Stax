//
//  Extensions.swift
//  Stax
//
//  Created by icbrahimc on 1/9/18.
//  Copyright © 2018 icbrahimc. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        
        //otherwise fire off a new download
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
                
                //download hit an error so lets return out
                if let error = error {
                    print(error)
                    return
                }
                
                DispatchQueue.main.async(execute: {
                    
                    if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        
                        self.image = downloadedImage
                    }
                })
                
            }).resume()
        }
    }
}

extension UIButton {
    func loadImageUsingCacheWithUrlString(_ urlString: String) {
        
        self.imageView?.image = nil
        
        //check cache for image first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            self.setImage(cachedImage, for: .normal)
            return
        }
        
        //otherwise fire off a new download
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            //download hit an error so lets return out
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                if let downloadedImage = UIImage(data: data!) {
                    imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                    
                    self.setImage(downloadedImage, for: .normal)
                }
            })
            
        }).resume()
    }
}

extension UIFont {
    func defaultFont(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Regular", size: size)!
    }
    
    func mediumFont(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Medium", size: size)!
    }
    
    func lightFont(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Light", size: size)!
    }
    
    func heavyFont(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Heavy", size: size)!
    }
    
    func heavyBlackFont(_ size: CGFloat) -> UIFont {
        return UIFont.init(name: "SFProDisplay-Black", size: size)!
    }
}
