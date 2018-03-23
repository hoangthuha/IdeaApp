import UIKit
import NVActivityIndicatorView

class IndicatorView {
    static let shared = IndicatorView()
    
    var indicator = NVActivityIndicatorView(frame: CGRect(x: 0,y: 0,width: 60,height: 60))
    var containerView = UIView()
    
    func show(_ view: UIView) {
        var viewShowing = view
        if let rootVC = UIApplication.shared.keyWindow?.rootViewController {
            viewShowing = rootVC.view
        }
        containerView.frame = viewShowing.frame
        containerView.center = viewShowing.center
        containerView.backgroundColor = UIColor(white: 0x000000, alpha: 0.4)
        
        indicator.type = .ballScaleMultiple
        indicator.center = CGPoint(x: viewShowing.bounds.width/2,y: viewShowing.bounds.height/2)
        indicator.startAnimating()
        containerView.addSubview(indicator)
        
        viewShowing.addSubview(containerView)
    }
    
    func hide(){
        indicator.stopAnimating()
        containerView.removeFromSuperview()
    }
}
