import Foundation

class StringUtils {
    class func className(_ obj: Any) -> String {
        return String(describing: type(of: (obj) as AnyObject)).components(separatedBy: "__").last!
    }
}
