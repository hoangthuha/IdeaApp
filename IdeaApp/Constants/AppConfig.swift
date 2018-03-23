import UIKit


struct AppConfig {
    
    static var configModel: ConfigModel?
    
    enum Client : Int {
        case android = 1
        case iOS = 0
    }
    
    static let language = Localize.currentLanguage()
    static let baseURL = "http://api.golfcaddie.hbbsolution.com"
    static let domain = "\(baseURL)/api/\("lang".localized())/"
    static let timeOut : Double = 8.0

}

