import Foundation
import UIKit
import AsyncDisplayKit

class Router {
    static let shared = Router()
    
    fileprivate var tabBarController: TabBarController!
    fileprivate var homeController: HomeController!
    fileprivate var scheduleController: ScheduleController!
    fileprivate var moreController: MoreController!
    
    fileprivate var authNavigationController : BaseNavigationController!
    
    func routeMeToAuthentication() {
        Driver.shared.routeType = .authenticate
        Device.keyWindow?.rootViewController = Router.shared.getAuthNavigationController()
    }
    
    func routeMeToHome() {
        Driver.shared.routeType = .home
        Device.keyWindow?.rootViewController = Router.shared.getTabbar()
    }
    
    func deinitTabBar() {
        if self.tabBarController != nil {
            self.homeController = nil
            self.scheduleController = nil
            self.moreController = nil
            self.tabBarController = nil
        }
    }
    
    func deinitAuthNavigationController() {
        if self.authNavigationController != nil {
            self.authNavigationController = nil
        }
    }
    
    func getTabbar() -> TabBarController {
        if self.tabBarController == nil {
            self.tabBarController = TabBarController()
        }
        return self.tabBarController
    }
    
    func getHomeController() -> HomeController {
        if self.homeController == nil {
            switch UserManager.shared.userType {
            case .golfer:
                self.homeController = HomeGolferController()
            case .caddie:
                self.homeController = CaddieHomeController()
            }        }
        return self.homeController
    }
    
    func getScheduleController() -> ScheduleController {
        if self.scheduleController == nil {
            switch UserManager.shared.userType {
            case .golfer:
                self.scheduleController = GolferScheduleController()
            case .caddie:
                self.scheduleController = CaddieScheduleController()
            }
        }
        return self.scheduleController
    }
    
    func getProfileController() -> MoreController {
        if self.moreController == nil {
            switch UserManager.shared.userType {
            case .golfer:
                self.moreController = GolferMoreController()
            case .caddie:
                self.moreController = CaddieMoreController()
            }
        }
        return self.moreController
    }
    
    func getAuthNavigationController() -> BaseNavigationController {
        if self.authNavigationController == nil {
            self.authNavigationController = BaseNavigationController(rootViewController: LoginController())
        }
        return self.authNavigationController
    }
}
