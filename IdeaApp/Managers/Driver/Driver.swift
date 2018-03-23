import Foundation
import UIKit

class Driver {
    
    static let shared = Driver()
    
    enum RouteType : Int {
        case authenticate = 0
        case home = 1
    }
    
    var routeType = RouteType.home
    
    // Get current naviagtionController
    class func currentNavigationController() -> UINavigationController? {
        if let tabBarViewController = self.topController() as? TabBarController {
            guard let navigationController = tabBarViewController.currentRootViewController as? UINavigationController else { return nil }
            return navigationController
        } else {
            guard let navigationController = self.topController() as? UINavigationController else { return nil }
            return navigationController
        }
    }
    
    // Top most Controller
    class func topController() -> UIViewController {
        var topController: UIViewController = self.rootViewController()
        while (topController.presentedViewController != nil) {
            topController = topController.presentedViewController!
        }
        return topController
    }
    
    // Get rootViewController
    class func rootViewController() -> UIViewController {
        switch self.shared.routeType {
        case .authenticate:
            return Router.shared.getAuthNavigationController()
        case .home:
            return Router.shared.getTabbar()
        }
    }
    
    // Pop To Root View Controller
    class func popToRootViewControllerAnimated(_ animated: Bool) {
        if let currentNavigationController = self.currentNavigationController() {
            currentNavigationController.popToRootViewController(animated: animated)
        }
    }
    
    // Push View Controller
    class func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if let currentNavigationController = self.currentNavigationController() {
            currentNavigationController.pushViewController(viewController, animated: animated)
        }
    }
    
    class func pushLikePresentViewController(_ viewController: UIViewController) {
        if let currentNavigationController = self.currentNavigationController() {
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionMoveIn
            transition.subtype = kCATransitionFromTop
            currentNavigationController.view.layer.add(transition, forKey: kCATransition)
            currentNavigationController.pushViewController(viewController, animated: false)
        }
    }
    
    class func popLikeDismissViewController() {
        if let currentNavigationController = self.currentNavigationController() {
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionReveal
            transition.subtype = kCATransitionFromBottom
            currentNavigationController.view.layer.add(transition, forKey: kCATransition)
            currentNavigationController.popViewController(animated: false)
        }
    }
    
    // Pop View Controller
    class func popViewControllerAnimated(_ animated: Bool) {
        if let currentNavigationController = self.currentNavigationController() {
            currentNavigationController.popViewController(animated: animated)
        }
    }
    
    // Present View Controller
    class func presentViewController(_ viewController:UIViewController, animated: Bool, completion: (() -> ())?) {
        self.topController().present(viewController, animated: animated, completion: completion)
    }
    
    // Show Detail View Controller
    class func showDetailViewController(_ viewController:UIViewController, sender: AnyObject) {
        if let currentNavigationController = self.currentNavigationController() {
            currentNavigationController.showDetailViewController(viewController, sender: sender)
        }
    }
}
