import UIKit

extension UIColor {
    
    /** Get color with hex */
    static func color(_ hex: Int, alpha: CGFloat = 1.0) -> UIColor {
        let red     = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green   = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue    = CGFloat((hex & 0xFF)) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func generateRandomColor() -> UIColor {
        let hue : CGFloat = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness : CGFloat = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }
    
}
