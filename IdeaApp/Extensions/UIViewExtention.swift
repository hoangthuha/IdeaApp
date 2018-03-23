import UIKit

extension UIView {
    
    var screenshot: UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image { ctx in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        }
        return image
    }
    
    func shake() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "position.x"
        animation.values = [0, 10, -10, 10, -5, 5, -5, 0 ]
        animation.keyTimes = [0, 0.125, 0.25, 0.375, 0.5, 0.625, 0.75, 0.875, 1]
        animation.duration = 0.6
        animation.isAdditive = true
        self.layer.add(animation, forKey: "shake")
    }
    
    func round(cornerRadius: CGFloat, color: UIColor = UIColor.clear, borderWidth: CGFloat = 0) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.clipsToBounds = true
    }
    
    func circle() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.clipsToBounds = true
    }
    
    func dropShadow(color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
    }
    
    func removeLayer(named: String) {
        if let sublayers = self.layer.sublayers {
            if sublayers.count > 0 {
                for sublayer in sublayers {
                    if sublayer.name == named {
                        sublayer.removeFromSuperlayer()
                    }
                }
            }
        }
    }
    
    func addRoundedDashLine(cornerRadius: CGFloat, fillColor: UIColor = UIColor.clear, strokeColor: UIColor, lineWidth: CGFloat, patthern: [NSNumber]) {
        let name = "Rounded Dash Line"
        self.removeLayer(named: name)
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.name = name
        shapeLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineDashPattern = patthern
        shapeLayer.cornerRadius = cornerRadius
        
        self.layer.addSublayer(shapeLayer)
    }
    
}

extension UIResponder {
    func parentController<T: UIViewController>(of type: T.Type) -> T? {
        guard let next = self.next else {
            return nil
        }
        return (next as? T) ?? next.parentController(of: T.self)
    }
}


extension UIView {
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }else {
            return self.leftAnchor
        }
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }else {
            return self.rightAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
}
