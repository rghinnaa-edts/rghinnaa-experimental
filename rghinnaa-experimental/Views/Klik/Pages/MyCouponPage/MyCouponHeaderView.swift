//
//  CouponOfferedHeaderView.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 09/01/26.
//

import UIKit
import KlikIDM_DS

class MyCouponHeaderView: UICollectionReusableView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var vTab: UIView!
    @IBOutlet weak var vTabTop: TabDefault!
    @IBOutlet weak var vTabFilter: TabDefault!
    
    private var couponTypeData: [TabDefaultModel] = []
    var couponFilterData: [TabDefaultModel] = []
    
    @IBOutlet weak var tabHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var tabFilterHeightConstraint: NSLayoutConstraint!
    
    var tabTopCell = "TabDefaultCell"
    var tabFilterCell = "TabChipCell"
    
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
    
    public func calculateHeight() -> CGFloat {
        let height = tabHeightConstraint.constant + tabFilterHeightConstraint.constant
        return height
    }
    
    public func getTabFilterTotal() -> Int {
        return couponFilterData.count
    }
    
    private func setupNib() {
        let bundle = Bundle(for: type(of: self))
        if let nib = bundle.loadNibNamed("MyCouponHeaderView", owner: self, options: nil),
           let view = nib.first as? UIView {
            
            containerView = view
            addSubview(containerView)
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            
            setupUI()
        }
    }
    
    private func setupUI() {
        setupTabTopUI()
        setupTabFilterUI()
    }
    
    func updateStickyAppearance(isSticky: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.vTab.layer.shadowOpacity = isSticky ? 0.1 : 0
        }
    }
    
    private func setupTabTopUI() {
        setupTabTopData()
        
        vTabTop.registerCellType(TabDefaultCell.self, withIdentifier: tabTopCell)
        
        vTabTop.data = couponTypeData
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
        vTabTop.selectDefaultTab()
    }
    
    private func setupTabFilterUI() {
        setupTabFilterData()
        
        vTabFilter.registerCellType(TabChipCell.self, withIdentifier: tabFilterCell)
        
        vTabFilter.isUserInteractionEnabled = true
        vTabFilter.layer.masksToBounds = false
        
        vTabFilter.data = couponFilterData
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
        
        vTabFilter.bgColor = UIColor.white
        vTabFilter.isScrollable = false
        vTabFilter.setDynamicWidth(enabled: true)
        vTabFilter.setItemPadding(
            leadingPadding : 16,
            trailingPadding :16,
            itemSpacing : 8
        )
        vTabFilter.selectDefaultTab()
        
        vTabFilter.layer.shadowColor = UIColor.black?.cgColor
        vTabFilter.layer.shadowOpacity = 0.1
        vTabFilter.layer.shadowOffset = CGSize(width: 0, height: 2)
        vTabFilter.layer.shadowRadius = 3
    }
    
    private func setupTabTopData() {
        couponTypeData = [
            TabDefaultModel(
            id: "1",
            title: "Potongan Total"),
            TabDefaultModel(
            id: "2",
            title: "Diskon Alat Bayar"),
            TabDefaultModel(
            id: "3",
            title: "Diskon Ongkir")
        ]
    }
    
    private func setupTabFilterData() {
        couponFilterData = [
            TabDefaultModel(
            id: "1",
            title: "Semua"),
            TabDefaultModel(
            id: "2",
            title: "Xtra"),
            TabDefaultModel(
            id: "3",
            title: "Xpress")
        ]
    }
}
