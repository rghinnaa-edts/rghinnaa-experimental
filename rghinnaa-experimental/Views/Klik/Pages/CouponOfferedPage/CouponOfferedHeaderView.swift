////
////  CouponOfferedHeaderView.swift
////  rghinnaa-experimental
////
////  Created by Rizka Ghinna Auliya on 09/01/26.
////
//
//import UIKit
//import KlikIDM_DS
//
//class CouponOfferedHeaderView: UICollectionReusableView {
//    
//    @IBOutlet var containerView: UIView!
//    @IBOutlet weak var vTab: UIView!
//    @IBOutlet weak var vTabTop: TabDefault!
//    @IBOutlet weak var vTabFilter: TabDefault!
//    
//    private var couponTypeData: [TabDefaultModel] = []
//    var couponFilterData: [TabDefaultModel] = []
//    
//    @IBOutlet weak var tabHeightConstraint: NSLayoutConstraint!
//    @IBOutlet weak var tabFilterHeightConstraint: NSLayoutConstraint!
//    
//    var tabTopCell = "TabDefaultCell"
//    var tabFilterCell = "TabChipCell"
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        setupNib()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        
//        setupNib()
//    }
//    
//    public func calculateHeight() -> CGFloat {
//        let height = tabHeightConstraint.constant + tabFilterHeightConstraint.constant
//        return height
//    }
//    
//    private func setupNib() {
//        let bundle = Bundle(for: type(of: self))
//        if let nib = bundle.loadNibNamed("CouponOfferedHeaderView", owner: self, options: nil),
//           let view = nib.first as? UIView {
//            
//            containerView = view
//            addSubview(containerView)
//            containerView.frame = bounds
//            containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
//            
//            setupUI()
//        }
//    }
//    
//    private func setupUI() {
//        setupTabTopBackgroundUI()
//        setupTabTopUI()
//        setupTabFilterUI()
//    }
//    
//    func updateStickyAppearance(isSticky: Bool) {
//        UIView.animate(withDuration: 0.3) {
//            self.vTab.layer.shadowOpacity = isSticky ? 0.1 : 0
//        }
//    }
//    
//    private func setupTabTopBackgroundUI() {
//        vTab.layer.cornerRadius = 16
//        vTab.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
//        vTab.layer.masksToBounds = true
//    }
//    
//    private func setupTabTopUI() {
//        setupTabTopData()
//        
//        vTabTop.registerCellType(TabDefaultCell.self, withIdentifier: tabTopCell)
//        vTabTop.delegate = self
//        
//        vTabTop.data = couponTypeData
//        vTabTop.cellConfiguration = { cell, data, isSelected, index in
//            guard let cell = cell as? TabDefaultCell else { return }
//                
//            cell.tabTextColor = UIColor.grey40
//            cell.tabTextActiveColor = UIColor.blue50
//            cell.tabBackgroundColor = .clear
//            cell.tabPaddingTop = 12.0
//            cell.tabPaddingBottom = 8.0
//        }
//        
//        vTabTop.bgColor = .clear
//        vTabTop.isScrollable = false
//        vTabTop.enableDynamicWidth()
//        vTabTop.selectDefaultTab()
//    }
//    
//    private func setupTabFilterUI() {
//        setupTabFilterData()
//        
//        vTabFilter.registerCellType(TabChipCell.self, withIdentifier: tabFilterCell)
//        vTabFilter.delegate = self
//        
//        vTabFilter.data = couponFilterData
//        vTabFilter.cellConfiguration = { cell, data, isSelected, index in
//            guard let cell = cell as? TabChipCell else { return }
//                
//            cell.titleColor = UIColor.blue50
//            cell.titleActiveColor = UIColor.white
//            cell.tabBgColor = UIColor.grey20
//            cell.tabBgActiveColor = UIColor.blue50
//            cell.tabCornerRadius = 12
//            cell.tabPaddingTop = 6
//            cell.tabPaddingBottom = 6
//            cell.tabPaddingLeading = 8
//            cell.tabPaddingTrailing = 8
//            cell.titleFontSize = 12
//            cell.titleFontWeight = "semibold"
//        }
//        
//        vTabFilter.bgColor = .clear
//        vTabFilter.isScrollable = false
//        vTabFilter.enableDynamicWidth()
//        vTabFilter.selectDefaultTab()
//    }
//    
//    private func setupTabTopData() {
//        couponTypeData = [
//            TabDefaultModel(
//            id: "1",
//            title: "Diskon Ongkir")
//        ]
//    }
//    
//    private func setupTabFilterData() {
//        couponFilterData = [
//            TabDefaultModel(
//            id: "1",
//            title: "Semua"),
//            TabDefaultModel(
//            id: "2",
//            title: "Xtra"),
//            TabDefaultModel(
//            id: "3",
//            title: "Xpress")
//        ]
//    }
//}
//
//extension CouponOfferedHeaderView : TabDefaultDelegate {
//    func didSelectTabDefault(at index: Int, withId id: String, cellIdentifier: String) {
//        
//    }
//}
