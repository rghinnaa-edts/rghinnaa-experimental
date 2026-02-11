//
//  MyCouponListCell.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 29/01/26.
//

import UIKit
import KlikIDM_DS

class MyCouponListCell: UICollectionViewCell {
    
    public var onVerticalScroll: ((UIScrollView) -> Void)?
    public var onHideTabFilter: ((UIScrollView) -> Void)?
    public var onShowTabFilter: ((UIScrollView) -> Void)?
    public var onVerticalScrollEnd: ((UIScrollView) -> Void)?
    public var isSkeleton: Bool = false {
        didSet {
            resetScrollPosition()
            setLoadingState(isSkeleton)
        }
    }
    
    private var collectionView: UICollectionView!
    private var containerView = UIView()
    private var data: [CardCouponOfferedModel] = []
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
        let headerView = MyCouponHeaderView()
        let headerHeight = headerView.calculateHeight() + 16
        
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
        collectionView.register(CardMyCouponCell.self, forCellWithReuseIdentifier: "CardMyCouponCell")
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        onVerticalScroll?(scrollView)
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        onHideTabFilter?(scrollView)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            onShowTabFilter?(scrollView)
        }
        
        onVerticalScrollEnd?(scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        onShowTabFilter?(scrollView)
    }
}

extension MyCouponListCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardMyCouponCell", for: indexPath) as! CardMyCouponCell
        
        cell.isSkeleton = isLoadingData ? true : false
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        
        return CGSize(width: width, height: 134)
    }
}
