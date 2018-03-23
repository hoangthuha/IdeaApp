import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        imageUrlString = urlString
        print(imageCache)
        let url = NSURL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, respones, error) in
            
            if error != nil {
                return
            }
            
            DispatchQueue.main.async(execute: {

                let imageToCache = UIImage(data: data!)
                if (imageToCache == nil) {
                    return
                }
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
            })
            
        }).resume()
    }
    
    func loadUserImageUsingUrlString(urlString: String) {
        imageUrlString = urlString
        
        let url = NSURL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, respones, error) in
            
            if error != nil {
                return
            }
            
            DispatchQueue.main.async(execute: {
                
                var imageToCache = UIImage(data: data!)
                if (imageToCache == nil) {
                    imageToCache = UIImage(named: "user_default")
                    self.image = imageToCache
                    imageCache.setObject(imageToCache!, forKey: urlString as AnyObject)
                    return
                }
                
                let imageData = UIImageJPEGRepresentation(imageToCache!, 0.25)
                let images = UIImage(data: imageData!)
                if self.imageUrlString == urlString {
                    self.image = images
                }
                imageCache.setObject(images!, forKey: urlString as AnyObject)
            })
            
        }).resume()
    }
}
