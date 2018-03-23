import Foundation
import UIKit

extension CALayer {
    func add() {
        self.removeAnimation(forKey: "foreImageViewRotationAnimation")
        let anaimation = CABasicAnimation(keyPath: "transform.rotation.z")
        anaimation.fromValue = 0
        anaimation.toValue = Double.pi * 2
        anaimation.duration = 10
        anaimation.repeatCount = MAXFLOAT
        anaimation.isRemovedOnCompletion = false
        self.add(anaimation, forKey: "foreImageViewRotationAnimation")
    }
    
    func pauseAnimation() {
        let pauseTime : CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pauseTime
    }
    
    func resumeAnimation() {
        let pauseTime : CFTimeInterval = timeOffset
        speed = 1.0
        timeOffset = 0.0
        beginTime = 0.0
        let timeSincePause : CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil) - pauseTime
        beginTime = timeSincePause
    }
}
