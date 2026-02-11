//
//  CouponOfferedHeaderView.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 09/01/26.
//

import UIKit
import KlikIDM_DS

class CouponOffered3HeaderView: UICollectionReusableView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var vTab: UIView!
    @IBOutlet weak var vTabTop: TabDefault!
    @IBOutlet weak var vTabFilter: TabDefault!
    
    @IBOutlet weak var tabHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tabFilterHeightConstraint: NSLayoutConstraint!
    
    public var couponTypeData: [TabDefaultModel] = [] {
        didSet {
            setTabTypeData(data: couponTypeData)
        }
    }
    public var couponFilterData: [TabDefaultModel] = [] {
        didSet {
            setTabFilterData(data: couponFilterData)
        }
    }
    
    public var tabTopCell = "TabDefaultCell"
    public var tabFilterCell = "TabChipCell"
    
    private var storedCouponTypeData: [TabDefaultModel] = []
    private var storedCouponFilterData: [TabDefaultModel] = []
    private var tabCurrentIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupNib()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        
        let tabPoint = convert(point, to: vTab)
        if vTab.bounds.contains(tabPoint) {
            return vTab.hitTest(tabPoint, with: event)
        }
        
        let tabFilterPoint = convert(point, to: vTabFilter)
        if vTabFilter.bounds.contains(tabFilterPoint) {
            return vTabFilter.hitTest(tabFilterPoint, with: event)
        }
        
        return hitView
    }
    
    public func removeTabTypeData() {
        storedCouponTypeData = []
    }
    
    public func removeTabFilterData() {
        storedCouponFilterData = []
    }
    
    public func calculateHeight() -> CGFloat {
        let height = tabHeightConstraint.constant + tabFilterHeightConstraint.constant
        return height
    }
    
    private func setupNib() {
        let bundle = Bundle(for: type(of: self))
        if let nib = bundle.loadNibNamed("CouponOfferedHeaderView", owner: self, options: nil),
           let view = nib.first as? UIView {
            
            containerView = view
            addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
            setupUI()
        }
    }
    
    private func setupUI() {
        setupTabTopBackgroundUI()
        setupTabTopUI()
        setupTabFilterUI()
    }
    
    func updateStickyAppearance(isSticky: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.vTab.layer.shadowOpacity = isSticky ? 0.1 : 0
        }
    }
    
    private func setupTabTopBackgroundUI() {
        vTab.layer.cornerRadius = 16
        vTab.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        vTab.layer.masksToBounds = true
    }
    
    private func setupTabTopUI() {
        vTabTop.registerCellType(TabDefaultCell.self, withIdentifier: tabTopCell)
        vTabTop.delegate = self
        
        vTabTop.data = storedCouponTypeData
        vTabTop.cellConfiguration = { cell, data, isSelected, index in
            guard let cell = cell as? TabDefaultCell else { return }
                
            cell.tabTextColor = UIColor.grey40
            cell.tabTextActiveColor = UIColor.blue50
            cell.tabBackgroundColor = .clear
            cell.tabPaddingTop = 12.0
            cell.tabPaddingBottom = 8.0
        }
        
        vTabTop.bgColor = .clear
        vTabTop.isScrollable = false
        vTabTop.setDynamicWidth(enabled: true)
    }
    
    private func setupTabFilterUI() {
        vTabFilter.registerCellType(TabChipCell.self, withIdentifier: tabFilterCell)
        vTabFilter.delegate = self
        
        vTabFilter.isUserInteractionEnabled = true
        vTabFilter.layer.masksToBounds = false
        
        vTabFilter.data = storedCouponFilterData
        vTabFilter.cellConfiguration = { cell, data, isSelected, index in
            guard let cell = cell as? TabChipCell else { return }
                
            cell.titleColor = UIColor.blue50
            cell.titleActiveColor = UIColor.white
            cell.tabBgColor = UIColor.grey20
            cell.tabBgActiveColor = UIColor.blue50
            cell.tabCornerRadius = 12
            cell.tabPaddingTop = 6
            cell.tabPaddingBottom = 6
            cell.tabPaddingLeading = 8
            cell.tabPaddingTrailing = 8
            cell.titleFontSize = 12
            cell.titleFontWeight = "semibold"
        }
        
        vTabFilter.bgColor = .clear
        vTabFilter.isScrollable = false
        vTabFilter.setDynamicWidth(enabled: true)
        vTabFilter.setItemPadding(
            leadingPadding : 16,
            trailingPadding :16,
            itemSpacing : 8
        )
    }
    
    private func setTabTypeData(data: [TabDefaultModel]) {
        if storedCouponTypeData.isEmpty {
            storedCouponTypeData = data
            setupTabTopUI()
        }
    }
    
    private func setTabFilterData(data: [TabDefaultModel]) {
        if storedCouponFilterData.isEmpty {
            storedCouponFilterData = data
            setupTabFilterUI()
        }
    }
}

extension CouponOffered3HeaderView : TabDefaultDelegate {
    func didSelectTabDefault(at index: Int, withId id: String, cellIdentifier: String) {
        
    }
}
