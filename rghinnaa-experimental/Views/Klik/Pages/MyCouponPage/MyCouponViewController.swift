//
//  MyCouponViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 21/01/26.
//

import UIKit
import KlikIDM_DS

class MyCouponViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private Variables
    
    private var isHeaderSticky = false
    private var isTabFilterHidden = false
    private var isLoadingData = true
    private var tabCurrentIndex: Int = 0
    
    private var couponOfferedData: [CouponOfferedModel] = []
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresh
    }()
    
    //MARK: - Initializers
    
    override func viewDidLoad() {
        setupCollectionView()
        setupRefreshControl()
    }
    
    //MARK: - Private Functions
    
    private func setupCollectionView() {
        setupCouponData()
        
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, environment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            section.interGroupSpacing = 0
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(0)
            )
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            header.pinToVisibleBounds = true
            
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = UIColor.grey10
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(MyCouponListCell.self, forCellWithReuseIdentifier: "MyCouponListCell")
        collectionView.register(
            MyCouponHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "MyCouponHeaderView"
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let firstItemPath = IndexPath(item: 0, section: 0)
        collectionView.scrollToItem(at: firstItemPath, at: .centeredHorizontally, animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            self.isLoadingData = false
            collectionView.reloadData()
        }
    }
    
    private func setupCouponData() {
        couponOfferedData = [
            CouponOfferedModel(
                id: "1",
                title: "Potongan Total",
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
                data: []
            ),
            CouponOfferedModel(
                id: "2",
                title: "Diskon Alat Bayar",
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
                    ),
                    TabDefaultModel(
                        id: "4",
                        title: "Ongkir"
                    )
                ],
                data: []
            ),
            CouponOfferedModel(
                id: "3",
                title: "Diskon Ongkir",
                tab: [
                    TabDefaultModel(
                        id: "1",
                        title: "Semua"
                    ),
                    TabDefaultModel(
                        id: "2",
                        title: "Xtra"
                    )
                ],
                data: []
            )
        ]
    }
    
    //MARK: - Animations
    
    private func verticalScrollView(_ scrollView: UIScrollView) {
        guard let headerView = self.collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(item: 0, section: 0)
        ) as? MyCouponHeaderView else { return }
        
        let isSticky = scrollView.contentOffset.y > 0
        if isSticky != self.isHeaderSticky {
            self.isHeaderSticky = isSticky
            headerView.updateStickyAppearance(isSticky: isSticky)
        }
        
        let threshold: CGFloat = 150
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset < threshold && self.isTabFilterHidden {
            self.showTabFilterView(scrollView, force: true)
        } else if scrollOffset >= threshold && !self.isTabFilterHidden {
            self.hideTabFilterView()
        }
    }
    
    private func hideTabFilterView() {
        guard let headerView = collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(item: 0, section: 0)
        ) as? MyCouponHeaderView else { return }
        
        isTabFilterHidden = true
        UIView.animate(withDuration: 0.2) {
            headerView.vTabFilter.transform = CGAffineTransform(translationX: 0, y: -headerView.vTabFilter.frame.height)
        }
    }
    
    private func showTabFilterView(_ scrollView: UIScrollView, force: Bool = false) {
        guard let headerView = collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(item: 0, section: 0)
        ) as? MyCouponHeaderView else { return }
        
        isTabFilterHidden = false
        
        let resetTransform = CGAffineTransform.identity
        UIView.animate(withDuration: 0.3) {
            headerView.vTabFilter.transform = resetTransform
        }
    }
    
    //MARK: - Refresh Control
    
    private func setupRefreshControl() {
        collectionView.refreshControl = refreshControl
        refreshControl.tintColor = UIColor.blue30
    }
    
    @objc private func handleRefresh() {
        isLoadingData = true
        collectionView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            
            self.isLoadingData = false
            self.collectionView.reloadData()
            
            self.refreshControl.endRefreshing()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

//MARK: - Collection View

extension MyCouponViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCouponListCell", for: indexPath) as! MyCouponListCell
        
        cell.isSkeleton = isLoadingData ? true : false
        
        cell.onVerticalScroll = { [weak self] scrollView in
            guard let self = self else { return }
            self.verticalScrollView(scrollView)
            
            if scrollView.contentOffset.y < -10 {
                self.collectionView.contentOffset.y = scrollView.contentOffset.y
            }
        }

        cell.onVerticalScrollEnd = { [weak self] scrollView in
            guard let self = self else { return }
            
            if scrollView.contentOffset.y <= -100 && !self.refreshControl.isRefreshing {
                self.refreshControl.beginRefreshing()
                UIView.animate(withDuration: 0.25) {
                    self.collectionView.contentOffset.y = -self.refreshControl.frame.height - self.collectionView.contentInset.top
                }
                self.handleRefresh()
            }
        }
        
        cell.onHideTabFilter = { [weak self] scrollview in
            guard let self = self else { return }
            hideTabFilterView()
        }
        
        cell.onShowTabFilter = { [weak self] scrollview in
            guard let self = self else { return }
            showTabFilterView(scrollview)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "MyCouponHeaderView",
                for: indexPath) as! MyCouponHeaderView
        
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView.backgroundView == nil {
            let backgroundView = UIView(frame: collectionView.bounds)
            backgroundView.backgroundColor = .clear
            collectionView.backgroundView = backgroundView
        }
    }
}

//MARK: - Delegate

extension MyCouponViewController: TabDefaultDelegate {
    func didSelectTabDefault(at index: Int, withId id: String, cellIdentifier: String) {
        guard let headerView = collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(item: 0, section: 0)
        ) as? MyCouponHeaderView else { return }
        
        if cellIdentifier == headerView.tabFilterCell {
            collectionView.reloadData()
        } else if cellIdentifier == headerView.tabTopCell {
            collectionView.reloadData()
            
            tabCurrentIndex = index
            headerView.removeTabFilterData()
            
            let indexPath = IndexPath(item: index, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
}
