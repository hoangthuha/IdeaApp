import UIKit

struct AppColor {
    
    static let white = UIColor.white
    static let background: Int = 0xEEEEEE
    static let primary: Int = 0x219653
    
    // button
    static let grayButton: Int = 0x797979
    static let oragneButton: Int = 0xED9445
    static let darkGreenButton: Int = 0x087339
    
    // text
    static let darkText: Int = 0x4A4A4A
    static let grayText: Int = 0x9B9B9B
    
    static let separator: Int = 0xD8D8D8
    
    static let lineView : Int = 0xDFDFDF
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
    
    static func colorWithRedValue(redValue: CGFloat, greenValue: CGFloat, blueValue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: redValue/255.0, green: greenValue/255.0, blue: blueValue/255.0, alpha: alpha)
    }
}
