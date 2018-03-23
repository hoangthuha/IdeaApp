//
//  BaseCollectionViewCell.swift
//  YoSing-iOS
//
//  Created by Thanh on 5/28/16.
//  Copyright © 2016 Zyncas. All rights reserved.
//

import UIKit

protocol BaseCollectionViewCellDelegate : class {}

class BaseCollectionViewCell: UICollectionViewCell {
    
    class var reuseIdentifier: String {
        return StringUtils.className(self)
    }
    
    weak var viewDelegate: BaseCollectionViewCellDelegate?
    
    required init(coder aDecoder: NSCoder) { super.init(coder: aDecoder)! }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
    
    class func getCellSize() -> CGSize { return CGSize.zero }
}
