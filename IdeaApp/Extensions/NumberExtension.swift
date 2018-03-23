import Foundation
import CoreGraphics

extension Int {
    // Format number like facebook
    func shortFormat() -> String {
        let HUND =                 100
        let THOU =                1000
        let MILL =             1000000
        let BILL =          1000000000
        let format = ["K", "M", "B", "T", "Q"]
        
        var surplus = ""
        
        if self < THOU {
            return String(self)
        } else if self < MILL {
            surplus = String(self%THOU)
            if self%THOU > HUND {
                return "\(self/THOU)" + "." + "\(surplus.substring(to: surplus.characters.index(surplus.startIndex, offsetBy: 1)))" + "\(format[0])"
            } else {
                return "\(self/THOU)" + "." + "0" + "\(format[0])"
            }
        } else  if self < BILL {
            surplus = String(self%MILL)
            if self%MILL > THOU {
                return "\(self/MILL)" + "." + "\(surplus.substring(to: surplus.characters.index(surplus.startIndex, offsetBy: 1)))" + "\(format[1])"
            } else {
                return "\(self/MILL)" + "." + "0" + "\(format[1])"
            }
        }
        surplus = String(self%BILL)
        if self%BILL > BILL {
            return "\(self/BILL)" + "." + "\(surplus.substring(to: surplus.characters.index(surplus.startIndex, offsetBy: 1)))" + "\(format[2])"
        } else {
            return "\(self/BILL)" + "." + "0" + "\(format[2])"
        }
    }
    
    func format(_ f: String) -> String {
        return String(format: "%\(f)d", self)
    }
}

extension UInt32 {
    public static func intFromHexString(_ hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: hexStr)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
}
