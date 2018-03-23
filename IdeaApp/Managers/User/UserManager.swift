import Foundation
import SwiftyJSON
import RocketData

enum PreferenceKeys : String {
    case currentUser = "currentUser"
    case deviceToken = "deviceToken"
    case token = "token"
    case faceImage = "faceImage"
    case faceEmail = "faceEmail"
    case faceStatus = "faceStatus"
    case isFirstLaunch = "isFirstLaunch"
}

class UserManager {
    
    static let shared = UserManager()
    
    private init() { }
    
    fileprivate let userDefaults = UserDefaults.standard
    
    enum UserType: Int {
        case golfer = 1
        case caddie = 2
    }
    
    var userType = UserType.caddie
    
    var faceEmail : String? {
        set {
            if let faceEmail = newValue {
                self.userDefaults.set(faceEmail, forKey: PreferenceKeys.faceEmail.rawValue)
            } else {
                self.userDefaults.removeObject(forKey: PreferenceKeys.faceEmail.rawValue)
            }
        }
        get {
            if let faceEmail = self.userDefaults.string(forKey: PreferenceKeys.faceEmail.rawValue) {
                return faceEmail
            }
            return nil
        }
    }
    
    var faceStatus : Bool {
        set {
            self.userDefaults.set(newValue, forKey: PreferenceKeys.faceStatus.rawValue)
        }
        get {
            if let faceStatus = self.userDefaults.value(forKey: PreferenceKeys.faceStatus.rawValue) as? Bool {
                return faceStatus
            }
            return false
        }
    }
    
    var faceImage : UIImage? {
        set {
            if let faceImage = newValue {
                if let data = UIImageJPEGRepresentation(faceImage, 1) {
                    self.userDefaults.set(data, forKey: PreferenceKeys.faceImage.rawValue)
                }
            } else {
                self.userDefaults.removeObject(forKey: PreferenceKeys.faceImage.rawValue)
            }
        }
        get {
            if let faceImage = self.userDefaults.data(forKey: PreferenceKeys.faceImage.rawValue) {
                if let image = UIImage.init(data: faceImage) {
                    return image
                }
            }
            return nil
        }
    }
    
    var deviceToken : String? {
        set {
            if let deviceToken = newValue {
                self.userDefaults.set(deviceToken, forKey: PreferenceKeys.deviceToken.rawValue)
            } else {
                self.userDefaults.removeObject(forKey: PreferenceKeys.deviceToken.rawValue)
            }
        }
        get {
            if let deviceToken = self.userDefaults.string(forKey: PreferenceKeys.deviceToken.rawValue) {
                return deviceToken
            }
            return nil
        }
    }
    
    var currentUser : UserModel? {
        set {
            if let user = newValue {
                self.userDefaults.set(user.encode(), forKey: PreferenceKeys.currentUser.rawValue)
            } else {
                self.userDefaults.removeObject(forKey: PreferenceKeys.currentUser.rawValue)
            }
        }
        get {
            guard let userData = self.userDefaults.data(forKey: PreferenceKeys.currentUser.rawValue) else { return nil }
            do {
                let user = try UserModel(json: JSON(data: userData))
                return user
            } catch let error {
                print(error.localizedDescription)
            }
            return nil
        }
    }
    
    var token : String? {
        set {
            if let token = newValue {
                self.userDefaults.set(token, forKey: PreferenceKeys.token.rawValue)
            } else {
                self.userDefaults.removeObject(forKey: PreferenceKeys.token.rawValue)
            }
        }
        get {
            if let token = self.userDefaults.string(forKey: PreferenceKeys.token.rawValue) {
                return token
            }
            return nil
        }
    }
    
    var isFirstLaunch : Bool{
        set {
            self.userDefaults.set(newValue, forKey: PreferenceKeys.isFirstLaunch.rawValue)
        }
        get {
            if self.userDefaults.value(forKey: PreferenceKeys.isFirstLaunch.rawValue) == nil{
                return false
        }
            return true
        }
    }
    
    func logOut() {
        self.deviceToken = nil
        self.currentUser = nil
        self.token = nil
        Router.shared.deinitTabBar()
        Router.shared.routeMeToAuthentication()
    }
    
    func logIn(token: String, facebookAccessToken: String?, deviceToken: String?, currentUser: UserModel) {
        self.deviceToken = deviceToken
        self.currentUser = currentUser
        self.token = token
        if currentUser.type == 1 {
            userType = .golfer
        } else {
            userType = .caddie
        }
    }
}
