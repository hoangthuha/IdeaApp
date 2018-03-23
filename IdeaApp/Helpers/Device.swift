import UIKit

class Device {
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenWidth = UIScreen.main.bounds.size.width
    static let originalMaxWidth = 640.0
    static let keyWindow = UIApplication.shared.delegate!.window!
    static let isIpad = (UI_USER_INTERFACE_IDIOM() == .pad)
    static let isIphone = (UI_USER_INTERFACE_IDIOM() == .phone)
    static let isRetina = (UIScreen.main.scale >= 2.0)
    static let screenMaxLength = (max(screenWidth, screenHeight))
    static let screenMinLength = (min(screenWidth, screenHeight))
    static let isIphone4OrLess = (isIphone && screenMaxLength < 568.0)
    static let isIphone5 = (isIphone && screenMaxLength == 568.0)
    static let isIphone6 = (isIphone && screenMaxLength == 667.0)
    static let isIphone6Plus = (isIphone && screenMaxLength == 736.0)
    
    static let isPhone = UIDevice.current.userInterfaceIdiom == .phone
    static let osVersion = UIDevice.current.systemVersion
    static let osName = UIDevice.current.name
    
    static var timezone: String {
        get {
            let localTimeZoneFormatter = DateFormatter()
            localTimeZoneFormatter.timeZone = TimeZone.autoupdatingCurrent
            localTimeZoneFormatter.dateFormat = "Z"
            return localTimeZoneFormatter.string(from: Date())
        }
    }
}
