import UIKit
 
@objc protocol BaseTableViewDelegate {
    @objc optional func handlePullToRefresh(tableView: UITableView?)
}

class BaseTableView: UITableView {
    
    var isFirstInitiated = true {
        didSet {
            if self.isRegisteredRefreshControl == true {
                DispatchQueue.main.async { self.addSubview(self.refreshControl!) }
            }
        }
    }
    
    var error = false
    
    weak var viewDelegate: BaseTableViewDelegate?
    
    var isRegisteredRefreshControl: Bool? = false {
        didSet {
            if self.isRegisteredRefreshControl == true {
                self.refreshControl = UIRefreshControl()
                self.refreshControl?.tintColor = UIColor.lightGray
                self.refreshControl?.addTarget(self, action: #selector(self.handlePullToRefresh),for: UIControlEvents.valueChanged)
            }
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        self.alwaysBounceVertical = true
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        self.initComponents()
        self.initConstraints()
        self.initProtocols()
        self.registerCells()
    }
    
    override func reloadSections(_ sections: IndexSet, with animation: UITableViewRowAnimation) {
        super.reloadSections(sections, with: animation)
        
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
    
    func reloadEmptyView(error: Bool, isFirstInitiated: Bool? = false, endRefreshing: Bool? = false) {
        self.error = error
        if isFirstInitiated == true { self.isFirstInitiated = false }
        self.reloadEmptyDataSet()
        if endRefreshing == true { self.endRefreshing() }
    }
    
    @objc func handlePullToRefresh() {
        if self.isRegisteredRefreshControl == true {
            self.viewDelegate?.handlePullToRefresh!(tableView: self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    internal func initComponents() {}
    internal func initConstraints() {}
    internal func registerCells() {}
    internal func initProtocols() {}
    
    deinit { NotificationCenter.default.removeObserver(self) }
    
    func register(_ cellClass: Swift.AnyClass, reuseIdentifier: String? = nil) {
        let identifier = reuseIdentifier ?? StringUtils.className(cellClass)
        self.register(cellClass.self, forCellReuseIdentifier: identifier)
    }
    
    func registerHeader(_ cellClass: Swift.AnyClass, reuseIdentifier: String? = nil) {
        let identifier = reuseIdentifier ?? StringUtils.className(cellClass)
        self.register(cellClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    func registerFooter(_ cellClass: Swift.AnyClass, reuseIdentifier: String? = nil) {
        let identifier = reuseIdentifier ?? StringUtils.className(cellClass)
        self.register(cellClass, forHeaderFooterViewReuseIdentifier: identifier)
    }
}
