import Foundation

let kLimitAgeOfUser = 12 //Year old'
let gLimitBooking = 5 //Year 

enum SignUpCellType {
    case none,fullName, address, email, phone, birthday, gender
}

enum TypeButtonDropDown : Int {
    case province = 0
    case course = 1
    case bookingDate = 2
    case timeTable = 3
    case numberCaddie = 4
    case none = -1
}

struct Padding{
    static let collectionView: CGFloat = 12
}

struct NotificationKeyName {
    static let tapOnStatusBar = "tapOnStatusBar"
}
//enum DirectoryType {
//    case cardPartner
//    case avatarCategory
//    case partnerIntroduce
//    case logoPartner
//    case newsPartner
//    case avatarCustomer
//    case logoBranch
//    case introduceBranch
//    case voucher
//
//    func urlImage(path : String) -> String {
//        switch self {
//        case .cardPartner:
//            return "\(AppConfig.directory?.cardPartner ?? "")/\(path)"
//        case .avatarCategory:
//            return "\(AppConfig.directory?.avatarCategory ?? "")/\(path)"
//        case .partnerIntroduce:
//            return "\(AppConfig.directory?.partnerIntroduce ?? "")/\(path)"
//        case .logoPartner:
//            return "\(AppConfig.directory?.logoPartner ?? "")/\(path)"
//        case .newsPartner:
//            return "\(AppConfig.directory?.newsPartner ?? "")/\(path)"
//        case .avatarCustomer:
//            return "\(AppConfig.directory?.avatarCustomer ?? "")/\(path)"
//        case .logoBranch:
//            return "\(AppConfig.directory?.logoBranch ?? "")/\(path)"
//        case .introduceBranch:
//            return "\(AppConfig.directory?.introduceBranch ?? "")/\(path)"
//        case .voucher:
//            return "\(AppConfig.directory?.voucher ?? "")/\(path)"
//        }
//    }
//}

public enum DateFormaterKey : String {
    case serverFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case dayMonthYear = "dd-MM-yyyy"
    case dayMonthYearHHMM = "dd-MM-yyyy HH:mm"
    case yearMonthDay =  "yyyy-MM-dd"
    case hhMMSS =  "HH:mm:ss"
    case hhMMSS12H = "hh:mm:ss"
    case fullDate = "EEEE, MMM d"
    case yearMonthDaySlash = "yyyy/MM/dd"
    case dayMonthYearSlash = "dd/MM/yyyy"
    case yearMonthDayHHMMSS = "yyyy-MM-dd HH:mm:ss"
    case hourMinutesDayMonthYearSlash = "hh:mm a dd/MM/yyyy"
    case monthDayYear = "MMMM d, yyyy"
    
    func language() -> String {
        switch self {
        case .dayMonthYear: return Localize.currentLanguage() == LanguageKey.vi ? "dd-MM-yyyy" : "MM-dd-yyyy"
        case .fullDate: return Localize.currentLanguage() == LanguageKey.vi ? "EEEE, d MMMM" : "EEEE, MMM d"
        default:
            return self.rawValue
        }
    }
}

struct LanguageKey {
    static let vi = "vi"
    static let en = "en"
}

