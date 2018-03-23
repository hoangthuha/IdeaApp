import Foundation

extension CGFloat {
    func customizeForAllDevices() -> CGFloat {
        return (self * (UIScreen.main.bounds.size.width / 375))
    }
}

extension CGSize {
    func customizeForAllDevices() -> CGSize {
        let ratio = 375 / UIScreen.main.bounds.size.width
        let width = self.width / ratio
        let height = self.height / ratio
        
        return CGSize(width: width, height: height)
    }
    
    func customizeFullWidthForAllDevices() -> CGSize {
        let ratio = 375 / UIScreen.main.bounds.size.width
        let height = self.height / ratio
        
        return CGSize(width: UIScreen.main.bounds.size.width, height: height)
    }
}
