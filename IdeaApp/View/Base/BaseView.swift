import UIKit

@objc protocol BaseViewDelegate {}

class BaseView: UIView {
	
	weak var viewDelegate: BaseViewDelegate?
    weak var vc: UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = AppColor.white
        
		self.initComponents()
        self.initConstraints()
        addTargetFromButton()
    }
    
    var topPaddingLayoutGuide: CGFloat {
        if #available(iOS 11.0, *) {
            return 0
        } else {
            return 20
        }
    }
    
    init(frame: CGRect, viewController: UIViewController) {
        super.init(frame: frame)
        self.vc = viewController
        self.initComponents()
        self.initConstraints()
        addTargetFromButton()
    }
    
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

    internal func initComponents() {}
    internal func initConstraints() {}
    internal func addTargetFromButton() {}
    
    deinit { NotificationCenter.default.removeObserver(self) }
}
