//
//  MyCouponListCell.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 29/01/26.
//

import UIKit
import KlikIDM_DS

class CouponOfferedListCell: UICollectionViewCell {
    
//    public var onVerticalScroll: ((UIScrollView) -> Void)?
//    public var onHideTabFilter: ((UIScrollView) -> Void)?
//    public var onShowTabFilter: ((UIScrollView) -> Void)?
    public var onScrollViewDidScroll: ((UIScrollView) -> Void)?
    public var onScrollViewBeginDragging: ((UIScrollView) -> Void)?
    public var onScrollViewDidEndDragging:((UIScrollView, Bool) -> Void)?
    public var onScrollViewDidEndDecelerating:((UIScrollView) -> Void)?

    public var onShowToast: ((String) -> Void)?
    public var onShowLoadingBlockScreen: ((String) -> Void)?
    public var onHideLoadingBlockScreen: (() -> Void)?
    
    public var isSkeleton: Bool = false {
        didSet {
            resetScrollPosition()
            setLoadingState(isSkeleton)
        }
    }
    
    private var collectionView: UICollectionView!
    private var containerView = UIView()
    private var data: [CardCouponOfferedModel] = []
    private var filteredCouponData: [CardCouponOfferedModel] = []
    private var isLoadingData = false
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    public func loadData(data: [CardCouponOfferedModel]) {
        self.data = data
    }
    
    public func setLoadingState(_ isLoading: Bool) {
        self.isLoadingData = isLoading
        self.collectionView.reloadData()
    }
    
    private func resetScrollPosition() {
        collectionView.setContentOffset(.zero, animated: false)
    }
    
    private func setupUI() {
        createUI()
        setupCollectionView()
        
        setLoadingState(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            self.setLoadingState(false)
        }
    }
    
    private func createUI() {
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.addSubview(containerView)
    }
    
    private func setupCollectionView() {
        let headerView = CouponOfferedHeaderView()
        let headerHeight = headerView.calculateHeight()
        
        let couponFlowLayout = UICollectionViewFlowLayout()
        couponFlowLayout.scrollDirection = .vertical
        couponFlowLayout.minimumInteritemSpacing = 16
        couponFlowLayout.minimumLineSpacing = 16
        couponFlowLayout.sectionInset = UIEdgeInsets(top: headerHeight, left: 16, bottom: 16, right: 16)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: couponFlowLayout)
        collectionView.backgroundColor = UIColor.grey10
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.alwaysBounceVertical = true
        collectionView.canCancelContentTouches = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        collectionView.register(CardCouponOfferedCell.self, forCellWithReuseIdentifier: "CardCouponOfferedCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        containerView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: containerView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}

extension CouponOfferedListCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isLoadingData ? 8 : data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCouponOfferedCell", for: indexPath) as! CardCouponOfferedCell
        
        cell.isSkeleton = isLoadingData ? true : false
        
        if isLoadingData {
            cell.isSkeleton = true
        } else {
            cell.isSkeleton = false
            cell.loadData(data: data[indexPath.row])
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        
        return CGSize(width: width, height: 200)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onScrollViewDidScroll?(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        onScrollViewBeginDragging?(scrollView)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        onScrollViewDidEndDragging?(scrollView, decelerate)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        onScrollViewDidEndDecelerating?(scrollView)
    }
}

extension CouponOfferedListCell: CardCouponOfferedCellDelegate {
    func didSelectButtonDetail(at index: Int) {
    }
    
    func didSelectButtonExchange(at index: Int, isCanExchange: Bool, isExchanged: Bool) {
        if !isCanExchange {
            if #available(iOS 10.0, *) {
                let generator = UIImpactFeedbackGenerator(style: .heavy)
                generator.impactOccurred()
            }
            onShowToast?("Kupon tidak bisa ditukar")
//            showToast(message: "Kupon tidak bisa ditukar")
        } else {
            if !isExchanged {
//                showLoadingBlockScreen()
                onShowLoadingBlockScreen?("")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                    guard let self = self else { return }
                    
//                    self.onHideLoadingBlockScreen {
//                        if let cell = self.collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? CardCouponOfferedCell {
//                            cell.cardCouponOffered.startFloatingAnimation()
//                        }
                        
//                        self.filteredCouponData[index].isExchanged = true
//                        self.filteredCouponData[index].periode = "7 Hari Lagi"
                        
//                        if let indexData = self.couponData.firstIndex(where: { $0.id == self.filteredCouponData[index].id }) {
//                            self.data[indexData].isExchanged = true
//                            self.data[indexData].periode = "7 Hari Lagi"
//                        }
//                        
//                        self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
//                        
//                        self.setupMyCouponCard()
//                    }
                }
            }
        }
    }
}
