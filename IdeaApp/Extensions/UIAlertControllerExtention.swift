import UIKit

extension UIAlertController {
    func showInViewController(_ viewController: UIViewController, sender: AnyObject?, view: UIView) {
        if Device.isPhone {
            DispatchQueue.main.async {
                viewController.showDetailViewController(self, sender: sender)
            }
        } else {
            self.modalPresentationStyle = .popover
            let popPresenter = self.popoverPresentationController
            popPresenter?.sourceView = view
            popPresenter?.sourceRect = view.bounds
            DispatchQueue.main.async {
                viewController.showDetailViewController(self, sender: sender)
            }
        }
    }
}
