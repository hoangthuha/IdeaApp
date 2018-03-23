//
//  BaseTableViewCell.swift
//  Yosing
//
//  Created by Doyle Illusion on 10/13/16.
//  Copyright © 2016 Zyncas. All rights reserved.
//

import UIKit

protocol BaseTableViewCellDelegate : class {}

class BaseTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        return StringUtils.className(self)
    }
    
    weak var viewDelegate: BaseTableViewCellDelegate?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initComponents()
        self.initConstraints()
        self.initRasterization()
    }
    
    internal func initRasterization() {
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
    
    internal func initComponents() {}
    internal func initConstraints() {}
    
    deinit { NotificationCenter.default.removeObserver(self) }
    
    class func getCellSize() -> CGFloat { return 0.0 }
}
