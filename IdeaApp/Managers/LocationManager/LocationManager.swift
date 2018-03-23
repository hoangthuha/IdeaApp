import UIKit
import CoreLocation

enum LocationType {
    case restricted
    case denied
    case notDetermined
    case allowed
}

class LocationManager: NSObject, CLLocationManagerDelegate{
    let locationManager = CLLocationManager()
    var seenError : Bool = false
    var locationFixAchieved : Bool = false
    var locationStatus : NSString = "Not Started"
    var locationType = LocationType.denied
    
    var latitude = Observable<Double>(0)
    var longtitude = Observable<Double>(0)
    
    static let shared = LocationManager()
    
    var completionHandler: ((LocationType) -> ())!
    var completionHandleUpdatingLocation : (()->())!
    
    func initLocationManager() {
        seenError = false
        locationFixAchieved = false
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self
        if CLLocationManager.locationServicesEnabled() {

            locationManager.distanceFilter = 1000 //100met
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    // Location Manager Delegate stuff
    // If failed
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        if (seenError == false) {
            seenError = true
            print(error.localizedDescription)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
//        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.latitude.set(locValue.latitude)// = locValue.latitude
        self.longtitude.set(locValue.longitude) //= locValue.longitude
    }
    
    // authorization status
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        var shouldIAllow = false
        
        switch status {
        case CLAuthorizationStatus.restricted:
            locationType = .restricted
            locationStatus = "Restricted Access to location"
        case CLAuthorizationStatus.denied:
            locationType = .denied
            locationStatus = "User denied access to location"
        case CLAuthorizationStatus.notDetermined:
            locationType = .notDetermined
            locationStatus = "Status not determined"
        default:
            locationType = .allowed
            locationStatus = "Allowed to location Access"
            shouldIAllow = true
        }
//        NSNotificationCenter.defaultCenter().postNotificationName("LabelHasbeenUpdated", object: nil)
        if (shouldIAllow == true) {
            NSLog("Location to Allowed")
            // Start location services
            locationManager.startUpdatingLocation()
        } else {
            NSLog("Denied access: \(locationStatus)")
            locationManager.stopUpdatingLocation()
        }
        
        if let completion = completionHandler {
            completion(locationType)
        }
    }
}
