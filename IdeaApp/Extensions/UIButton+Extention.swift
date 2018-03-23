import UIKit

extension UIButton {
    static func cornerRadiusButton(_ bt: UIButton, _ radius: CGFloat){
        bt.layer.cornerRadius = radius
        bt.layer.masksToBounds = true
    }
    
}
