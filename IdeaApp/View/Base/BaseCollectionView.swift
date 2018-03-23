import UIKit

@objc protocol BaseCollectionViewDelegate {
    @objc optional func handlePullToRefresh(collectionView: UICollectionView?)
}

class BaseCollectionView: UICollectionView {
    
    var isFirstInitiated = true {
        didSet {
            if self.isRegisteredRefreshControl == true {
                DispatchQueue.main.async { self.addSubview(self.refreshControl!) }
            }
        }
    }
    
    var error = false
    
    weak var viewDelegate: BaseCollectionViewDelegate?
        
    let layout = BaseCollectionViewLayout()
    
    var isRegisteredRefreshControl: Bool? = false {
        didSet {
            if self.isRegisteredRefreshControl == true {
                self.refreshControl = UIRefreshControl()
                self.refreshControl?.tintColor = .lightGray
                self.refreshControl?.addTarget(self, action: #selector(self.handlePullToRefresh),for: UIControlEvents.valueChanged)
            }
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: CGRect.zero, collectionViewLayout: self.layout)
        
        
        self.alwaysBounceVertical = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.initComponents()
        self.initConstraints()
        self.registerCells()
        self.initProtocols()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func reloadSections(_ sections: IndexSet) {
        super.reloadSections(sections)
        
        if self.isRegisteredRefreshControl == true {
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        
        if self.isRegisteredRefreshControl == true {
            self.refreshControl?.endRefreshing()
        }
    }
    
    @objc func handlePullToRefresh(collectionView: UICollectionView) {
        if self.isRegisteredRefreshControl == true {
            self.viewDelegate?.handlePullToRefresh!(collectionView: self)
        }
    }
    
    func endRefreshing() {
        if self.isRegisteredRefreshControl == true {
            self.refreshControl?.endRefreshing()
        }
    }
    
    func beginRefreshing() {
        if self.isRegisteredRefreshControl == true {
            self.refreshControl?.beginRefreshingManually()
        }
    }
    
    func scrollToTop() {
        self.scrollRectToVisible(CGRect(x: 0, y: 0, width: 1, height: 1), animated: true)
    }
    
    func scrollToBottom() {
        self.scrollRectToVisible(CGRect(x: self.contentSize.width - 1, y: self.contentSize.height - 1, width: 1, height: 1), animated: true)
    }
    
    internal func initComponents() {}
    internal func initConstraints() {}
    internal func initProtocols() {}
    internal func registerCells() {}
    
    deinit { NotificationCenter.default.removeObserver(self) }
    
    func reloadEmptyView(error: Bool, isFirstInitiated: Bool? = false, endRefreshing: Bool? = false) {
        self.error = error
        if isFirstInitiated == true { self.isFirstInitiated = false }
        self.reloadEmptyDataSet()
        if endRefreshing == true { self.endRefreshing() }
    }
        
    func register(_ cellClass: Swift.AnyClass, reuseIdentifier: String? = nil) {
        let identifier = reuseIdentifier ?? StringUtils.className(cellClass)
        self.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    func registerHeader(_ cellClass: Swift.AnyClass, reuseIdentifier: String? = nil) {
        let identifier = reuseIdentifier ?? StringUtils.className(cellClass)
        self.register(cellClass, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: identifier)
    }
    
    func registerFooter(_ cellClass: Swift.AnyClass, reuseIdentifier: String? = nil) {
        let identifier = reuseIdentifier ?? StringUtils.className(cellClass)
        self.register(cellClass, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath, reuseIdentifier identifier: String? = nil) -> T {
        let _identifier = identifier ?? StringUtils.className(cellClass)
        return self.dequeueReusableCell(withReuseIdentifier: _identifier, for: indexPath) as! T
    }
    
    func dequeueReusableHeaderCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath, reuseIdentifier identifier: String? = nil) -> T {
        let _identifier = identifier ?? StringUtils.className(cellClass)
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: _identifier, for: indexPath) as! T
    }
    
    func dequeueReusableFooterCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath, reuseIdentifier identifier: String? = nil) -> T {
        let _identifier = identifier ?? StringUtils.className(cellClass)
        return self.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: _identifier, for: indexPath) as! T
    }
}
