import Foundation
import UIKit

class NotificationFlow: NSObject {

    static let shared = NotificationFlow()
    
    func handleNotification(_ userInfo : [AnyHashable : Any]) {
        guard let status = userInfo["gcm.notification.status"] as? String else {
            return
        }
        guard let tabBar = Driver.topController() as? TabBarController else { return }
        UIApplication.shared.applicationIconBadgeNumber = 0
        switch UserManager.shared.userType {
        case .caddie:
            switch status {
            case "20": // New booking
                tabBar.selectedIndex = 0
                if let nav = tabBar.selectedViewController as? BaseNavigationController,
                    let home = nav.topViewController as? CaddieHomeController {
                    tabBar.currentRootViewController = nav
                    home.getBookingList(token: UserManager.shared.token, isFirstLoad: true)
                }
            case "21": // Golfer cancel booking
                break
            case "22": // Golfer pay booking
                tabBar.selectedIndex = 1
                if let nav = tabBar.selectedViewController as? BaseNavigationController, let vc = nav.topViewController as? CaddieScheduleController {
                    tabBar.currentRootViewController = nav
                    vc.setFirstVC(vc: vc.upComing)
                    vc.upComing.getBookingListBySchedule(token: UserManager.shared.token, isFirstLoad: true, option: .upcoming)
                }
            default:
                break
            }
        case .golfer:
            switch status {
            case "50": // Enough caddies
                tabBar.selectedIndex = 0
                if let nav = tabBar.selectedViewController as? BaseNavigationController,
                    let home = nav.topViewController as? HomeGolferController {
                    tabBar.currentRootViewController = nav
                    home._view.setFirstVC(vc: home._view.payGolfer)
                    home._view.payGolfer.getPaidBookingList(status: 3, token: UserManager.shared.token, isFirstLoad: true)
                }
                break
            case "51": // Caddie finish booking
                break
            case "69": // New tournament
                tabBar.selectedIndex = 0
                if let nav = tabBar.selectedViewController as? BaseNavigationController,
                    let home = nav.topViewController as? HomeGolferController {
                    tabBar.currentRootViewController = nav
                    home._view.setFirstVC(vc: home._view.tournament)
                    home._view.tournament.getTournamentList(isFirstLoad: true)
                }
                break
            default:
                break
            }
        }
    }
    
    func handleDirectoryController(_ destinationViewController: UIViewController, userInfo: [String: Any], status : String) {
    }

}

