import Foundation

class AuthorizationHelpers {
    static let shared = AuthorizationHelpers()
    
    func requestCameraAccess() {
        let cameraMediaType = AVMediaType.video
        AVCaptureDevice.requestAccess(for: cameraMediaType) { granted in
            if granted {
                print("Granted!!!")
            } else {
                print("Please allow access camera!")
            }
        }
    }
    
    var isUserLocationAvailable: Bool {
        if isLocationEnabled && isLocationEnabledForMyApp() {
            return true
        }
        return false
    }
    
    private func isLocationEnabledForMyApp() -> Bool {
        if CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            return true
        }
        return false
    }
    
    private var isLocationEnabled: Bool {
        return CLLocationManager.locationServicesEnabled()
    }
    
}
