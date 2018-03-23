import Foundation

extension UIRefreshControl {
    func beginRefreshingManually() {
        DispatchQueue.main.async {
            if let scrollView = self.superview as? UIScrollView {
                scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - self.frame.size.height), animated: true)
                self.beginRefreshing()
            }
        }
        self.sendActions(for: .valueChanged)
    }
}
