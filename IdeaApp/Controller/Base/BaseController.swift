import Foundation
import UIKit

class BaseController: UIViewController, BaseViewDelegate, BaseCollectionViewDelegate, BaseTableViewDelegate {
    
    
    var isHiddenNavigation : Bool = false {
        didSet{
            self.navigationController?.setNavigationBarHidden(isHiddenNavigation, animated: false)
        }
    }
    var contentView: UIView? {
        didSet {
            guard let contentView = self.contentView else { return }
            self.view = contentView
            self.setupContentDelegate()
        }
    }
    
    override var canBecomeFirstResponder : Bool { return true }
    override var preferredStatusBarStyle : UIStatusBarStyle { return .default }
    
    override func didReceiveMemoryWarning() { print("Memory warning!!") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBar()
        self.initData()
        self.configureInfiniteScroll()
        //self.registerNetworkNotification()
        self.configureControllerEdges()
        print(self)
       // self.updateNetwork(notification: nil)
    }
    
    
    internal func configureControllerEdges() {
        self.edgesForExtendedLayout = UIRectEdge()
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    internal func setupNavigationBar() {
        self.navigationController?.view.backgroundColor = AppColor.white
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "app.navigation.leftItem.title".localized(), style: .plain, target: self, action: #selector(self.didTouchBackButtonItem))
    }
    
    internal func removebottomLineNavigationBar(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    internal func transparentNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    internal func removeBehindTabbar(){
        self.edgesForExtendedLayout = []
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = false
    }
        
    fileprivate func setupContentDelegate() {
        if self.contentView!.isKind(of: BaseView.self) {
            if (self.contentView as! BaseView).viewDelegate == nil {
                (self.contentView as! BaseView).viewDelegate = self
            }
        }
        if self.contentView!.isKind(of: BaseCollectionView.self) {
            if (self.contentView as! BaseCollectionView).viewDelegate == nil {
                (self.contentView as! BaseCollectionView).viewDelegate = self
            }
        }
        if self.contentView!.isKind(of: BaseTableView.self) {
            if (self.contentView as! BaseTableView).viewDelegate == nil {
                (self.contentView as! BaseTableView).viewDelegate = self
            }
        }
    }
    
    internal func initData() {}
    internal func configureInfiniteScroll() {}
    
//    internal func registerNetworkNotification() {
//        NotificationCenter.default.addObserver(self, selector: #selector(didChangeNetworkConnection), name: .flagsChanged, object: Network.reachability)
//    }
    
//    @objc internal func didChangeNetworkConnection(notification: Notification?) {
//        self.updateNetwork(notification: notification)
//    }
    
//    internal func updateNetwork(notification: Notification?) {
//        guard let status = Network.reachability?.status else { return }
////        switch status {
////        case .unreachable:
////            let message = Message(title: "shared.network.unreachable".localized(), backgroundColor: UIColor.color(0x333533))
////            Whisper.showWhisperSimultaneously(whisper: message, to: self.navigationController!, action: .present)
////        case .wifi:
////            Whisper.hideWhisperSimultaneously(whisperFrom: self.navigationController!, after: 1)
////        case .wwan:
////            Whisper.hideWhisperSimultaneously(whisperFrom: self.navigationController!, after: 1)
////        }
//
//        print("Reachability Summary")
//        print("Status:", status)
//        print("HostName:", Network.reachability?.hostname ?? "nil")
//        print("Reachable:", Network.reachability?.isReachable ?? "nil")
//        print("Wifi:", Network.reachability?.isReachableViaWiFi ?? "nil")
//
//        guard let navigationController = self.navigationController else { return }
//        switch status {
//        case .unreachable:
//            let message = Message(title: "shared.network.unreachable".localized(), backgroundColor: UIColor.color(0x333533))
//            guard let navigationController = self.navigationController else { return }
//            Whisper.showWhisperSimultaneously(whisper: message, to: navigationController, action: .present)
//        case .wifi:
//            Whisper.hideWhisperSimultaneously(whisperFrom: navigationController, after: 1)
//        case .wwan:
//            Whisper.hideWhisperSimultaneously(whisperFrom: navigationController, after: 1)
//        }
//    }
    
    @objc fileprivate func didTouchBackButtonItem() { Driver.popViewControllerAnimated(true) }

    deinit{
        NotificationCenter.default.removeObserver(self)
        print("\(StringUtils.className(self)) is being deinitialized")
    }
}

// MARK: Indentifier
extension BaseController {
    class func identifier() -> String { return StringUtils.className(self) }
}
