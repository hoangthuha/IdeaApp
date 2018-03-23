import Foundation


extension UIImageView {
    
     func cornerRadiusImage(radius: CGFloat){
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}

extension UIImage {
    func crop(_ cropRect : CGRect) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(cropRect.size, false, 2)
        UIGraphicsBeginImageContextWithOptions(cropRect.size, false, self.scale)
        let origin = CGPoint(x: cropRect.origin.x * CGFloat(-1), y: cropRect.origin.y * CGFloat(-1))
        self.draw(at: origin)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return result
    }
    
    func compressImageTo500kb(_ left: Float, _ right: Float) -> Data? {
        let scale = (left + right)/2
        guard var imageData:Data = UIImageJPEGRepresentation(self, CGFloat(scale)) else {
            return nil
        }
        let imageSize = (CGFloat(imageData.count))/1000.0
        print("Left: \(left), Right: \(right), Size: = \(imageSize)")
        if (right == 1 && imageSize <= 500) {
            print("Original image not scale: \(imageSize)")
            return imageData
        } else if scale <= 0.01 && imageSize <= 500 {
            print("Final: \(scale), Size: = \(imageSize)")
            return imageData
        } else if scale <= 0.01 && imageSize > 500 {
            print("Minimum Size: = \(imageSize)")
            //Special case here
            return imageData
        } else if String(format:"%.2f",scale) == String(format:"%.2f",left) && imageSize <= 500 {
            print("Final: \(scale), Size: = \(imageSize)")
            return imageData
        } else if (imageSize >= 480 && imageSize <= 500) {
            print("Final: \(scale), Size: = \(imageSize)")
            return imageData
        } else if imageSize > 500 {
            return compressImageTo500kb(left, scale)
        } else {
            return compressImageTo500kb(scale, right)
        }
    }
    
    func base64ToString () -> String?{
        let imageData = UIImagePNGRepresentation(self)
        let base64String = imageData?.base64EncodedString(options: .init(rawValue: 0))
        return base64String
    }
    func resize(newWidth : CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
}
