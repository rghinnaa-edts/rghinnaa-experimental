//
//  CouponOfferedViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 29/12/25.
//

import UIKit
import KlikIDM_DS

class CouponOfferedViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var btnBackToolbar: UIButton!
    @IBOutlet weak var lblToolbar: UILabel!
    @IBOutlet weak var vToolbar: UIView!
    @IBOutlet weak var vTabTop: TabDefault!
    @IBOutlet weak var vTabFilter: TabDefault!
    @IBOutlet weak var vContainerContent: UIView!
    @IBOutlet weak var couponCollectionView: UICollectionView!
    
    private var couponTypeData: [TabDefaultModel] = []
    private var couponFilterData: [TabDefaultModel] = []
    private var couponData: [CardCouponOfferedModel] = []
    
    @IBOutlet weak var couponCollectionViewHeightConstraint: NSLayoutConstraint!
    
    private var isHeaderSticky = false
    private let toolbarHeight: CGFloat = 44
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        setupScrollView()
        setupTabTopUI()
        setupTabFilterUI()
        setupCollectionView()
    }
    
    private func setupScrollView() {
        scrollView.delegate = self
    }
    
    private func setupTabTopUI() {
        setupTabTopData()
        
        vTabTop.registerCellType(TabDefaultCell.self, withIdentifier: "TabDefaultCell")
        vTabTop.delegate = self
        
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
        vTabTop.enableDynamicWidth()
        vTabTop.selectDefaultTab()
    }
    
    private func setupTabFilterUI() {
        setupTabFilterData()
        
        vTabFilter.registerCellType(TabChipCell.self, withIdentifier: "TabChipCell")
        vTabFilter.delegate = self
        
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
//            cell.titleFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        }
        
        vTabFilter.bgColor = .clear
        vTabFilter.isScrollable = false
        vTabFilter.enableDynamicWidth()
        vTabFilter.selectDefaultTab()
    }
    
    func setupCollectionView() {
        let couponFlowLayout = UICollectionViewFlowLayout()
        couponFlowLayout.scrollDirection = .vertical
        couponFlowLayout.minimumInteritemSpacing = 16
        couponFlowLayout.minimumLineSpacing = 16
        couponFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        couponCollectionView.collectionViewLayout = couponFlowLayout
        couponCollectionView.backgroundColor = UIColor.grey10
        couponCollectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        couponCollectionView.register(CardCouponOfferedCell.self, forCellWithReuseIdentifier: "CardCouponOfferedCell")
        
        couponCollectionView.delegate = self
        couponCollectionView.dataSource = self
        
//        couponCollectionViewHeightConstraint = couponCollectionView.heightAnchor.constraint(equalToConstant: 0)
//        couponCollectionViewHeightConstraint?.isActive = true
        
        setupCouponData()
    }
    
    private func updateCollectionViewHeight() {
        couponCollectionView.layoutIfNeeded()
        couponCollectionViewHeightConstraint?.constant = couponCollectionView.contentSize.height
    }
    
    private func calculateCollectionViewContentHeight() -> CGFloat {
        return couponCollectionView.contentSize.height
    }
    
    private func setupTabTopData() {
        couponTypeData = [
            TabDefaultModel(
            id: "1",
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
    
    private func setupCouponData() {
//        couponData = [
//           CardCouponOfferedModel(
//            id: "1",
//            image: UIImage(named: "discount-shipment"),
//            title: "Diskon Ongkir 5% Hingga Pakai Pengiriman Tertentu",
//            isFairGeneral: false,
//            fairGeneralType: FairGeneralType.general.rawValue,
//            mininumTransaction: 30000,
//            service: "Xpress, Xtra",
//            periode: "7 Hari Lagi",
//            couponCode: "BARUINSTAN10RB***",
//            disableInfo: "",
//            isEnabled: true,
//            isNewUser: true,
//            isExchanged: false,
//            isCanExchange: true
//            ),
//           CardCouponOfferedModel(
//            id: "2",
//            image: UIImage(named: "discount-shipment"),
//            title: "Diskon Ongkir Rp10.000 Pakai",
//            isFairGeneral: true,
//            fairGeneralType: FairGeneralType.exclusive.rawValue,
//            mininumTransaction: 30000,
//            service: "Xpress, Xtra",
//            periode: "7 Hari Lagi",
//            couponCode: "BARUINSTAN10RB***",
//            disableInfo: "",
//            isEnabled: true,
//            isNewUser: false,
//            isExchanged: false,
//            isCanExchange: false
//            ),
//           CardCouponOfferedModel(
//            id: "3",
//            image: UIImage(named: "discount-shipment"),
//            title: "Diskon Ongkir Rp10.000 Pakai",
//            isFairGeneral: true,
//            fairGeneralType: FairGeneralType.general.rawValue,
//            mininumTransaction: 30000,
//            service: "Xpress, Xtra",
//            periode: "7 Hari Lagi",
//            couponCode: "BARUINSTAN10RB***",
//            disableInfo: "",
//            isEnabled: true,
//            isNewUser: false,
//            isExchanged: false,
//            isCanExchange: true
//            ),
//           CardCouponOfferedModel(
//            id: "4",
//            image: UIImage(named: "discount-shipment"),
//            title: "Diskon Ongkir Rp10.000 Pakai",
//            isFairGeneral: false,
//            fairGeneralType: FairGeneralType.general.rawValue,
//            mininumTransaction: 30000,
//            service: "Xpress, Xtra",
//            periode: "7 Hari Lagi",
//            couponCode: "BARUINSTAN10RB***",
//            disableInfo: "",
//            isEnabled: true,
//            isNewUser: false,
//            isExchanged: false,
//            isCanExchange: true
//            ),
//           CardCouponOfferedModel(
//            id: "5",
//            image: UIImage(named: "discount-shipment"),
//            title: "Diskon Ongkir Rp10.000 Pakai",
//            isFairGeneral: true,
//            fairGeneralType: FairGeneralType.general.rawValue,
//            mininumTransaction: 30000,
//            service: "Xpress, Xtra",
//            periode: "7 Hari Lagi",
//            couponCode: "BARUINSTAN10RB***",
//            disableInfo: "",
//            isEnabled: true,
//            isNewUser: false,
//            isExchanged: false,
//            isCanExchange: true
//            ),
//        ]
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension CouponOfferedViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return couponData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCouponOfferedCell", for: indexPath) as! CardCouponOfferedCell
        
        cell.loadData(data: couponData[indexPath.row])
        cell.cornerRadius = 12
        cell.shadowColor = .lightGray
        cell.shadowOpacity = 0.3
        cell.shadowOffset = CGSize(width: 0, height: 2)
        cell.shadowRadius = 4
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        
        return CGSize(width: width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            DispatchQueue.main.async {
                self.updateCollectionViewHeight()
            }
        }
    }
}

extension CouponOfferedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateToolbarColor(scrollView)
    }
    
    private func updateToolbarColor(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
           
           let stickyThreshold: CGFloat = 108 - toolbarHeight
           let fadeStartOffset: CGFloat = max(0, stickyThreshold - 50)
           
           let progress = min(max((offsetY - fadeStartOffset) / (stickyThreshold - fadeStartOffset), 0), 1)
           
           vToolbar.backgroundColor = UIColor(white: 1.0, alpha: progress)
           btnBackToolbar.tintColor = progress > 0.5 ? UIColor.grey50 : .white
           lblToolbar.textColor = progress > 0.5 ? UIColor.grey70 : .white
           
           if offsetY >= stickyThreshold && !isHeaderSticky {
               isHeaderSticky = true
               couponCollectionView.isScrollEnabled = true
           } else if offsetY < stickyThreshold && isHeaderSticky {
               isHeaderSticky = false
               couponCollectionView.isScrollEnabled = false
           }
    }
}

extension CouponOfferedViewController: TabDefaultDelegate {
    func didSelectTabDefault(at index: Int, withId id: String, cellIdentifier: String) {
        
    }
}
