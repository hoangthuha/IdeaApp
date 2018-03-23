import Foundation
import UserNotifications


extension UIApplication {
    class func openAppSettings() {
        UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
    }
    
    class func isNotificationEnabled(completion:@escaping (_ enabled:Bool)->()){
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings: UNNotificationSettings) in
                let status =  (settings.authorizationStatus == .authorized)
                DispatchQueue.main.async {
                    completion(status)
                }
            })
        }
    }
    
    var statusView: UIView? {
        return UIApplication.shared.value(forKey: "statusBar") as? UIView
    }
}
