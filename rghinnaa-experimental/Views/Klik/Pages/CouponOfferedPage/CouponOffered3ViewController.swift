//
//  CouponOffered2ViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 09/01/26.
//

import UIKit
import KlikIDM_DS

class CouponOffered3ViewController: UIViewController {
    
    
    //MARK: - Outlets
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var ivCouponOfferedBackground: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vToolbar: UIView!
    @IBOutlet weak var vMyCouponCard: CardMyCoupon!
    @IBOutlet weak var vBackgroundCoupon: UIView!
    @IBOutlet weak var btnBackToolbar: UIButton!
    @IBOutlet weak var lblToolbar: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    
    //MARK: - Private Variables
    
    private var couponTypeData: [TabDefaultModel] = []
    private var couponFilterData: [TabDefaultModel] = []
    
    private var couponOfferedData: [CouponOfferedModel] = []
    private var filteredCouponData: [CardCouponOfferedModel] = []
    private var tabCurrentIndex = 0
    
    private let refreshControl = UIRefreshControl()
    private let refreshIconImageView = UIImageView()
    private let refreshContainerView = UIView()
    private var isRefreshAnimating = false
    
    private let toolbarHeight: CGFloat = 44
    private let myCouponCardHeight: CGFloat = 104
    private let tabSectionHeight: CGFloat = 104
    private var isHeaderSticky = false
    private var isTabFilterHidden = false
    private var isLoadingData = true
    
    private var loadingBlockView: UIView?
    private var loadingIndicator: UIActivityIndicatorView?
    
    private var currentStatusBarStyle: UIStatusBarStyle = .lightContent
        
    //MARK: - Initializers
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return currentStatusBarStyle
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        setupUI()
        setupRefreshControl()
    }
    
    
    //MARK: - Private Functions
    
    private func setupUI() {
        scrollView.delegate = self
        vMyCouponCard.delegate = self
        
        vMyCouponCard.isBadgeSkeleton = true
        
        setupCollectionView()
        setupViewBackground()
    }
    
    private func setupMyCouponCard() {
        let totalExchanged = couponOfferedData[tabCurrentIndex].data.filter(\.isExchanged).count
        vMyCouponCard.title = "Kupon Saya"
        vMyCouponCard.desc = "Kumpulan kupon yang kamu punya"
        vMyCouponCard.badgeLabel = totalExchanged > 10 ? "10+" : "\(totalExchanged)"
    }
    
    private func setupViewBackground() {
        vBackgroundCoupon.layer.cornerRadius = 16
        vBackgroundCoupon.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        vBackgroundCoupon.layer.masksToBounds = true
    }
    
    //MARK: - Collection View Setup
    
    private func setupCollectionView() {
        setupCouponData()
        setupMyCouponCard()
        
        let couponFlowLayout = UICollectionViewFlowLayout()
        couponFlowLayout.scrollDirection = .vertical
        couponFlowLayout.minimumInteritemSpacing = 16
        couponFlowLayout.minimumLineSpacing = 16
        couponFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        couponFlowLayout.sectionHeadersPinToVisibleBounds = false
        
        collectionView.collectionViewLayout = couponFlowLayout
        collectionView.backgroundColor = UIColor.grey10
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        collectionView.register(CardCouponOfferedCell.self, forCellWithReuseIdentifier: "CardCouponOfferedCell")
        collectionView.register(
            CouponOffered3HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "CouponOffered3HeaderView"
        )
        
        collectionView.layer.cornerRadius = 16
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.layer.masksToBounds = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            self.isLoadingData = false
            self.vMyCouponCard.isBadgeSkeleton = false
            self.filterCouponData(by: "all")
            collectionView.reloadData()
            
            setupMyCouponCard()
        }
        
        updateCollectionViewHeight()
    }
    
    private func updateCollectionViewHeight() {
        collectionView.layoutIfNeeded()
                
        let contentHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
        let availableHeight = scrollView.frame.height - (myCouponCardHeight + toolbarHeight - 2)
        let finalHeight = max(contentHeight, availableHeight)
        
        collectionViewHeightConstraint.constant = finalHeight
        
        UIView.animate(withDuration: 0) {
            self.view.layoutIfNeeded()
        }
    }
        
    private func calculateCollectionViewContentHeight() -> CGFloat {
        return self.collectionView.contentSize.height
    }
    
    //MARK: - Refresh Control
    
    private func setupRefreshControl() {
        refreshControl.tintColor = .clear
        refreshControl.backgroundColor = .clear
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        
        refreshContainerView.translatesAutoresizingMaskIntoConstraints = false
        refreshControl.addSubview(refreshContainerView)
        
        refreshIconImageView.translatesAutoresizingMaskIntoConstraints = false
        refreshIconImageView.contentMode = .scaleAspectFit
        refreshIconImageView.image = UIImage(named: "ic-refresh")
        refreshIconImageView.tintColor = .systemBlue
        refreshContainerView.addSubview(refreshIconImageView)
        
        NSLayoutConstraint.activate([
            refreshContainerView.centerXAnchor.constraint(equalTo: refreshControl.centerXAnchor),
            refreshContainerView.centerYAnchor.constraint(equalTo: refreshControl.centerYAnchor),
            refreshContainerView.widthAnchor.constraint(equalToConstant: 40),
            refreshContainerView.heightAnchor.constraint(equalToConstant: 40),
            
            refreshIconImageView.centerXAnchor.constraint(equalTo: refreshContainerView.centerXAnchor),
            refreshIconImageView.centerYAnchor.constraint(equalTo: refreshContainerView.centerYAnchor),
            refreshIconImageView.widthAnchor.constraint(equalToConstant: 32),
            refreshIconImageView.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        scrollView.refreshControl = refreshControl
    }
    
    private func startRefreshAnimation() {
        isRefreshAnimating = true
        isLoadingData = true
        vMyCouponCard.isBadgeSkeleton = true
        collectionView.reloadData()
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.fromValue = 0
        rotation.toValue = Double.pi * 2
        rotation.duration = 0.8
        rotation.repeatCount = .infinity
        rotation.timingFunction = CAMediaTimingFunction(name: .linear)
        refreshIconImageView.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    private func stopRefreshAnimation() {
        setupCouponData()
        isRefreshAnimating = false
        refreshIconImageView.layer.removeAllAnimations()
        
        UIView.animate(withDuration: 0.2) {
            self.isLoadingData = false
            self.vMyCouponCard.isBadgeSkeleton = false
            
            self.filterCouponData(by: "all")
            self.collectionView.reloadData()
            self.updateCollectionViewHeight()
            
            self.refreshIconImageView.transform = .identity
        }
    }
    
    private func updateRefreshProgress(_ progress: CGFloat) {
        guard !isRefreshAnimating else { return }
        
        let progress = min(max(progress, 0), 1)
        let rotation = CGAffineTransform(rotationAngle: .pi * 2 * progress)
        let scale = 0.2 + (0.8 * progress)
        let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
        
        refreshIconImageView.transform = rotation.concatenating(scaleTransform)
        refreshIconImageView.alpha = 0.5 + (0.5 * progress)
    }
    
    //MARK: - Block Screen Loading
    
    private func showLoadingBlockScreen() {
        hideLoadingBlockScreen()
        
        let blockView = UIView(frame: view.bounds)
        blockView.backgroundColor = UIColor.black?.withAlphaComponent(0.5)
        blockView.alpha = 0
        
        let indicator: UIActivityIndicatorView
        if #available(iOS 13.0, *) {
            indicator = UIActivityIndicatorView(style: .large)
        } else {
            indicator = UIActivityIndicatorView(style: .whiteLarge)
        }
        indicator.color = .white
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        blockView.addSubview(indicator)
        view.addSubview(blockView)
        
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: blockView.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: blockView.centerYAnchor)
        ])
        
        loadingBlockView = blockView
        loadingIndicator = indicator
        
        indicator.startAnimating()
        
        UIView.animate(withDuration: 0.3) {
            blockView.alpha = 1
        }
    }
    
    private func hideLoadingBlockScreen(completion: (() -> Void)? = nil) {
        guard let blockView = loadingBlockView else {
            completion?()
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: {
            blockView.alpha = 0
        }) { _ in
            self.loadingIndicator?.stopAnimating()
            blockView.removeFromSuperview()
            self.loadingBlockView = nil
            self.loadingIndicator = nil
            completion?()
        }
    }
    
    //MARK: - Toast
    
    private func showToast(message: String, font: UIFont = .systemFont(ofSize: 12.0)) {
        let toastContainer = UIView(frame: CGRect(x: self.view.frame.minX + 16,
                                                  y: self.view.frame.maxY - 96,
                                                  width: self.view.frame.size.width - 32,
                                                  height: 48))
        toastContainer.backgroundColor = UIColor.grey60
        toastContainer.layer.cornerRadius = 10
        toastContainer.clipsToBounds = true
        
        let toastLabel = UILabel(
            frame: CGRect(x: 16,
                          y: 0,
                          width: toastContainer.frame.width - 32,
                          height: toastContainer.frame.height))
        toastLabel.backgroundColor = .clear
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .left
        toastLabel.text = message
        toastLabel.numberOfLines = 0
        
        toastContainer.addSubview(toastLabel)
        toastContainer.alpha = 1.0
        self.view.addSubview(toastContainer)
        
        UIView.animate(withDuration: 1.0, delay: 2.0, options: .curveEaseOut, animations: {
            toastContainer.alpha = 0.0
        }) { _ in
            toastContainer.removeFromSuperview()
        }
    }
    
    //MARK: - Data Models Static
    
    private func setupCouponData() {
        couponOfferedData = [
            CouponOfferedModel(
                id: "1",
                title: "Diskon Ongkir",
                tab: [
                    TabDefaultModel(
                        id: "1",
                        title: "Semua"
                    ),
                    TabDefaultModel(
                        id: "2",
                        title: "Xtra"
                    ),
                    TabDefaultModel(
                        id: "3",
                        title: "Xpress"
                    )
                ],
                data: [
                    CardCouponOfferedModel(
                     id: "1",
                     image: UIImage(named: "discount-shipment"),
                     title: "Diskon Ongkir 5% Hingga Pakai Pengiriman Tertentu",
                     filterType: "xpress",
                     isFairGeneral: false,
                     fairGeneralType: FairGeneralType.general.rawValue,
                     mininumTransaction: 30000,
                     service: "Xpress, Xtra",
                     periode: "1",
                     couponCode: "BARUINSTAN10RB***",
                     disableInfo: "",
                     isEnabled: true,
                     isNewUser: true,
                     isExchanged: true,
                     isCanExchange: true
                     ),
                    CardCouponOfferedModel(
                     id: "2",
                     image: UIImage(named: "discount-shipment"),
                     title: "Diskon Ongkir Rp10.000 Pakai",
                     filterType: "xtra",
                     isFairGeneral: false,
                     fairGeneralType: FairGeneralType.exclusive.rawValue,
                     mininumTransaction: 30000,
                     service: "Xpress, Xtra",
                     periode: "1 Des 2025 - 31 Jan 2026",
                     couponCode: "BARUINSTAN10RB***",
                     disableInfo: "",
                     isEnabled: true,
                     isNewUser: false,
                     isExchanged: false,
                     isCanExchange: false
                     ),
                    CardCouponOfferedModel(
                     id: "3",
                     image: UIImage(named: "discount-shipment"),
                     title: "Diskon Ongkir Rp10.000 Pakai",
                     filterType: "xtra",
                     isFairGeneral: false,
                     fairGeneralType: FairGeneralType.general.rawValue,
                     mininumTransaction: 30000,
                     service: "Xpress, Xtra",
                     periode: "1 Des 2025 - 31 Jan 2026",
                     couponCode: "BARUINSTAN10RB***",
                     disableInfo: "",
                     isEnabled: true,
                     isNewUser: false,
                     isExchanged: false,
                     isCanExchange: true
                     ),
                    CardCouponOfferedModel(
                     id: "4",
                     image: UIImage(named: "discount-shipment"),
                     title: "Diskon Ongkir Rp10.000 Pakai",
                     filterType: "xtra",
                     isFairGeneral: false,
                     fairGeneralType: FairGeneralType.general.rawValue,
                     mininumTransaction: 30000,
                     service: "Xpress, Xtra",
                     periode: "1 Des 2025 - 31 Jan 2026",
                     couponCode: "BARUINSTAN10RB***",
                     disableInfo: "",
                     isEnabled: true,
                     isNewUser: false,
                     isExchanged: false,
                     isCanExchange: true
                     ),
                    CardCouponOfferedModel(
                     id: "5",
                     image: UIImage(named: "discount-shipment"),
                     title: "Diskon Ongkir Rp10.000 Pakai",
                     filterType: "xpress",
                     isFairGeneral: false,
                     fairGeneralType: FairGeneralType.general.rawValue,
                     mininumTransaction: 30000,
                     service: "Xpress, Xtra",
                     periode: "7 hari lagi",
                     couponCode: "BARUINSTAN10RB***",
                     disableInfo: "Limit promo sudah habis. Cek promo lainnya yang tersedia yuk!",
                     isEnabled: true,
                     isNewUser: false,
                     isExchanged: false,
                     isCanExchange: true
                     ),
                    CardCouponOfferedModel(
                     id: "6",
                     image: UIImage(named: "discount-shipment"),
                     title: "Diskon Ongkir Rp10.000 Pakai",
                     filterType: "xpress",
                     isFairGeneral: false,
                     fairGeneralType: FairGeneralType.general.rawValue,
                     mininumTransaction: 30000,
                     service: "Xpress, Xtra",
                     periode: "7 hari lagi",
                     couponCode: "BARUINSTAN10RB***",
                     disableInfo: "Kuota promo sudah habis. Cek promo lainnya yang tersedia yuk!",
                     isEnabled: true,
                     isNewUser: false,
                     isExchanged: false,
                     isCanExchange: true
                     ),
                    CardCouponOfferedModel(
                     id: "7",
                     image: UIImage(named: "discount-shipment"),
                     title: "Diskon Ongkir Rp10.000 Pakai",
                     filterType: "xtra",
                     isFairGeneral: false,
                     fairGeneralType: FairGeneralType.general.rawValue,
                     mininumTransaction: 30000,
                     service: "Xpress, Xtra",
                     periode: "7 hari lagi",
                     couponCode: "BARUINSTAN10RB***",
                     disableInfo: "Promo tidak tersedia, Cek promo lainnya yuk!",
                     isEnabled: false,
                     isNewUser: false,
                     isExchanged: false,
                     isCanExchange: true
                     ),
                    
                    CardCouponOfferedModel(
                     id: "8",
                     image: UIImage(named: "discount-shipment"),
                     title: "Diskon Ongkir Rp10.000 Pakai",
                     filterType: "xpress",
                     isFairGeneral: false,
                     fairGeneralType: FairGeneralType.general.rawValue,
                     mininumTransaction: 30000,
                     service: "Xpress, Xtra",
                     periode: "7 hari lagi",
                     couponCode: "BARUINSTAN10RB***",
                     disableInfo: "Yuk, selesaikan transaksi sebelumnya untuk bisa gunakan promo ini.",
                     isEnabled: false,
                     isNewUser: false,
                     isExchanged: false,
                     isCanExchange: true
                     )
                 ]
            )
        ]
    }
    
    private func filterCouponData(by filterType: String) {
        if filterType == "all" || filterType == "semua" {
            filteredCouponData = couponOfferedData[tabCurrentIndex].data
        } else {
            filteredCouponData = couponOfferedData[tabCurrentIndex].data.filter { $0.filterType == filterType }
        }
    }
    
    //MARK: - Animations
    
    private func updateRefresh() {
        if !refreshControl.isRefreshing && !isRefreshAnimating {
            let offsetY = scrollView.contentOffset.y
            let progress = min(abs(offsetY) / 60.0, 1.0)
            updateRefreshProgress(progress)
        }
    }
    
    private func updateToolbarColor(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let progress = min(max((offsetY - toolbarHeight) / toolbarHeight, 0), 1)

        if offsetY > 0 {
            vToolbar.transform = CGAffineTransform(translationX: 0, y: offsetY)
        } else {
            vToolbar.transform = .identity
        }
        
        let newStyle: UIStatusBarStyle = progress > 0.9 ? .darkContent : .lightContent
        if currentStatusBarStyle != newStyle {
            currentStatusBarStyle = newStyle
            setNeedsStatusBarAppearanceUpdate()
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
            self.btnBackToolbar.tintColor = progress > 0.9 ? UIColor.grey50 : UIColor.white
            self.lblToolbar.textColor = progress > 0.9 ? UIColor.grey70 : UIColor.white
            self.containerView.backgroundColor = progress > 0.9 ? UIColor.white : .blue70
            self.ivCouponOfferedBackground.isHidden = progress > 0.9 ? true : false
        }
        
        self.vToolbar.backgroundColor = progress > 0.9 ? .white : .clear
    }
    
    private func updateMyCouponCard(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let myCouponCardOffset = 1.1
        
        if offsetY > 0 && offsetY <= myCouponCardHeight {
            vMyCouponCard.transform = CGAffineTransform(translationX: 0, y: offsetY * myCouponCardOffset)
        } else if offsetY > myCouponCardHeight {
            vMyCouponCard.transform = CGAffineTransform(translationX: 0, y: myCouponCardHeight * myCouponCardOffset)
        } else {
            vMyCouponCard.transform = .identity
        }
    }
    
    private func updateStickyHeader(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        guard let headerView = collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(item: 0, section: 0)
        ) as? CouponOffered3HeaderView else { return }
        
        let fadeProgress = min(max(offsetY / myCouponCardHeight, 0), 1)
        vMyCouponCard.alpha = 1 - fadeProgress
        
        let stickyPoint = myCouponCardHeight
        let stickyOffset = offsetY - stickyPoint
        
        if offsetY >= stickyPoint {
            let hideTabFilterOffset: CGFloat = isTabFilterHidden ? -headerView.vTabFilter.frame.height : 0
            
            headerView.vTab.transform = CGAffineTransform(translationX: 0, y: stickyOffset)
            headerView.vTab.layer.cornerRadius = 0
            
            headerView.vTabFilter.transform = CGAffineTransform(translationX: 0, y: stickyOffset + hideTabFilterOffset)
            headerView.vTabFilter.layer.shadowColor = UIColor.black?.cgColor
            headerView.vTabFilter.layer.shadowOpacity = 0.1
            headerView.vTabFilter.layer.shadowOffset = CGSize(width: 0, height: 2)
            headerView.vTabFilter.layer.shadowRadius = 4
            headerView.vTabFilter.bgColor = .white
        } else {
            isTabFilterHidden = false
            
            headerView.vTab.transform = .identity
            headerView.vTabFilter.bgColor = .clear
            headerView.vTabFilter.layer.shadowOpacity = 0
            headerView.vTabFilter.transform = .identity
        }
    }
    
    private func hideTabFilterView() {
        guard let headerView = collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(item: 0, section: 0)
        ) as? CouponOffered3HeaderView else { return }
        
        let offsetY = scrollView.contentOffset.y
        let stickyPoint = myCouponCardHeight
        let stickyOffset = max(0, offsetY - stickyPoint)
        
        isTabFilterHidden = true
        
        UIView.animate(withDuration: 0.2, delay: 0, options: [.curveEaseOut, .beginFromCurrentState]) {
            headerView.vTabFilter.transform = CGAffineTransform(translationX: 0, y: stickyOffset - headerView.vTabFilter.frame.height)
        }
    }
    
    private func showTabFilterView() {
        let offsetY = scrollView.contentOffset.y
        let stickyPoint = myCouponCardHeight
        
        isTabFilterHidden = false
        
        if offsetY >= stickyPoint {
            guard let headerView = collectionView.supplementaryView(
                forElementKind: UICollectionView.elementKindSectionHeader,
                at: IndexPath(item: 0, section: 0)
            ) as? CouponOffered3HeaderView else { return }
            
            let stickyOffset = max(0, offsetY - stickyPoint)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut, .beginFromCurrentState]) {
                headerView.vTabFilter.transform = CGAffineTransform(translationX: 0, y: stickyOffset)
            }
        }
    }
    
    //MARK: - Actions
    
    @objc private func handleRefresh() {
        startRefreshAnimation()
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.stopRefreshAnimation()
            self?.refreshControl.endRefreshing()
        }
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


//MARK: - Collection View

extension CouponOffered3ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isLoadingData ? 8 : filteredCouponData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCouponOfferedCell", for: indexPath) as! CardCouponOfferedCell
        
        if isLoadingData {
            cell.isSkeleton = true
        } else {
            cell.isSkeleton = false
            cell.loadData(data: filteredCouponData[indexPath.row])
        }
        
        cell.delegate = self
        cell.cornerRadius = 12
        cell.shadowColor = .lightGray
        cell.shadowOpacity = 0.4
        cell.shadowOffset = CGSize(width: 0, height: 1)
        cell.shadowRadius = 3
        cell.bgColor = .white
        cell.index = indexPath.row
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "CouponOffered3HeaderView",
                for: indexPath) as! CouponOffered3HeaderView
        
        let couponTypeData = couponOfferedData.map { couponType in
            TabDefaultModel(
                id: couponType.id,
                title: couponType.title
            )
        }
        let couponFilterData = couponOfferedData[tabCurrentIndex].tab
        
        headerView.couponTypeData = couponTypeData
        headerView.couponFilterData = couponFilterData
        
        if isLoadingData {
            headerView.vTabTop.skeletonItemTotal = 2
            headerView.vTabTop.isSkeleton = true
            
            headerView.vTabFilter.skeletonItemTotal = 3
            headerView.vTabFilter.isSkeleton = true
            
            headerView.removeTabTypeData()
            headerView.removeTabFilterData()
        } else {
            headerView.vTabTop.isSkeleton = false
            headerView.vTabFilter.isSkeleton = false
            
            headerView.couponTypeData = couponTypeData
            headerView.couponFilterData = couponFilterData
        }
        
        headerView.vTabTop.delegate = self
        headerView.vTabFilter.delegate = self

        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        let height = CardCouponOfferedCell().calculateHeight(for: width)
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let header = CouponOffered3HeaderView()
        
        return CGSize(width: view.frame.width, height: header.calculateHeight())
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.backgroundView == nil {
            let backgroundView = UIView(frame: collectionView.bounds)
            backgroundView.backgroundColor = .clear
            collectionView.backgroundView = backgroundView
        }
    }
}

//MARK: - ScrollView

extension CouponOffered3ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateRefresh()
        updateToolbarColor(scrollView)
        updateMyCouponCard(scrollView)
        updateStickyHeader(scrollView)
        
        let offsetY = scrollView.contentOffset.y
        let stickyPoint = myCouponCardHeight
        
        if scrollView.isDragging && offsetY >= stickyPoint && !isTabFilterHidden {
            hideTabFilterView()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let stickyPoint = myCouponCardHeight
        
        if offsetY >= stickyPoint {
            hideTabFilterView()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            showTabFilterView()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        showTabFilterView()
    }
}


//MARK: - Delegates

extension CouponOffered3ViewController: CardCouponOfferedCellDelegate {
    func didSelectButtonDetail(at index: Int) {
    }
    
    func didSelectButtonExchange(at index: Int, isCanExchange: Bool, isExchanged: Bool) {
        if !isCanExchange {
            showLoadingBlockScreen()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                guard let self = self else { return }
                
                self.hideLoadingBlockScreen {
                    self.scrollView.setContentOffset(.zero, animated: true)
                    
                    if #available(iOS 10.0, *) {
                        let generator = UIImpactFeedbackGenerator(style: .heavy)
                        generator.impactOccurred()
                    }
                    self.showToast(message: "Kupon tidak bisa ditukar")
                    
                    self.isLoadingData = true
                    self.vMyCouponCard.isBadgeSkeleton = true
                    self.collectionView.reloadData()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                        guard let self = self else { return }
                        self.isLoadingData = false
                        self.vMyCouponCard.isBadgeSkeleton = false
                        self.filterCouponData(by: "all")
                        collectionView.reloadData()
                        
                        setupMyCouponCard()
                    }
                }
            }
        } else {
            if !isExchanged {
                showLoadingBlockScreen()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                    guard let self = self else { return }
                    
                    self.hideLoadingBlockScreen {
                        if let cell = self.collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? CardCouponOfferedCell {
                            cell.cardCouponOffered.startFloatingAnimation()
                        }
                        
                        self.filteredCouponData[index].isExchanged = true
                        self.filteredCouponData[index].periode = "7 Hari Lagi"
                        
                        if let indexData = self.couponOfferedData[self.tabCurrentIndex].data.firstIndex(where: { $0.id == self.filteredCouponData[index].id }) {
                            self.couponOfferedData[self.tabCurrentIndex].data[indexData].isExchanged = true
                            self.couponOfferedData[self.tabCurrentIndex].data[indexData].periode = "7 Hari Lagi"
                        }
                        
                        self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
                        
                        self.setupMyCouponCard()
                    }
                }
            }
        }
    }
}

extension CouponOffered3ViewController: TabDefaultDelegate {
    func didSelectTabDefault(at index: Int, withId id: String, cellIdentifier: String) {
        guard let headerView = collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(item: 0, section: 0)
        ) as? CouponOffered3HeaderView else { return }
        
        if cellIdentifier == headerView.tabTopCell {
            scrollView.setContentOffset(.zero, animated: true)
            
            tabCurrentIndex = index
            headerView.removeTabFilterData()
            
            filteredCouponData.removeAll()
            filterCouponData(by: "all")
            
            collectionView.reloadData()
            updateCollectionViewHeight()
        }
        
        if cellIdentifier == headerView.tabFilterCell {
            scrollView.setContentOffset(.zero, animated: true)
            
            filteredCouponData.removeAll()
            filterCouponData(by: couponOfferedData[tabCurrentIndex].tab[index].title.lowercased())
            
            collectionView.reloadData()
            updateCollectionViewHeight()
        }
    }
}

extension CouponOffered3ViewController: CardMyCouponDelegate {
    func didSelectCard(_ card: KlikIDM_DS.CardMyCoupon) {
        let vc = UIStoryboard(name: "MyCouponViewController", bundle: nil).instantiateViewController(withIdentifier: "MyCouponPage")
        navigationController?.pushViewController(vc, animated: true)
    }
}
