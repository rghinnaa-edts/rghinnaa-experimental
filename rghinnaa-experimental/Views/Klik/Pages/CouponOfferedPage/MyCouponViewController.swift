//
//  MyCouponViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 21/01/26.
//

import UIKit
import KlikIDM_DS

class MyCouponViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var isHeaderSticky = false
    private var isTabFilterHidden = false
    private var isLoadingData = true
    
    override func viewDidLoad() {
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let couponFlowLayout = UICollectionViewFlowLayout()
        couponFlowLayout.scrollDirection = .vertical
        couponFlowLayout.minimumInteritemSpacing = 16
        couponFlowLayout.minimumLineSpacing = 16
        couponFlowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        couponFlowLayout.sectionHeadersPinToVisibleBounds = true
        
        collectionView.collectionViewLayout = couponFlowLayout
        collectionView.backgroundColor = UIColor.grey10
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0)
        collectionView.register(CardMyCouponCell.self, forCellWithReuseIdentifier: "CardMyCouponCell")
        collectionView.register(
            MyCouponHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "MyCouponHeaderView"
        )
        
        collectionView.layer.cornerRadius = 16
        collectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        collectionView.layer.masksToBounds = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            guard let self = self else { return }
            self.isLoadingData = false
            collectionView.reloadData()
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
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
}

extension MyCouponViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardMyCouponCell", for: indexPath) as! CardMyCouponCell
        
        if isLoadingData {
            cell.isSkeleton = true
        } else {
            cell.isSkeleton = false
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    
        let headerView = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: "MyCouponHeaderView",
                for: indexPath) as! MyCouponHeaderView
        headerView.vTabFilter.delegate = self

        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        
        return CGSize(width: width, height: 134)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let header = CouponOfferedHeaderView()
        
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.contentOffset.y = 0
        }
        
        guard let headerView = collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(item: 0, section: 0)
        ) as? MyCouponHeaderView else { return }
        
        let isSticky = scrollView.contentOffset.y > 0
        if isSticky != isHeaderSticky {
            isHeaderSticky = isSticky
            headerView.updateStickyAppearance(isSticky: isSticky)
        }
        
        let threshold: CGFloat = 150
        let scrollOffset = scrollView.contentOffset.y
        
        if scrollOffset < threshold && isTabFilterHidden {
            showTabFilterView(scrollView, force: true)
        } else if scrollOffset >= threshold && !isTabFilterHidden {
            hideTabFilterView()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideTabFilterView()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            showTabFilterView(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        showTabFilterView(scrollView)
    }
}

extension MyCouponViewController: TabDefaultDelegate {
    func didSelectTabDefault(at index: Int, withId id: String, cellIdentifier: String) {
        guard let headerView = collectionView.supplementaryView(
            forElementKind: UICollectionView.elementKindSectionHeader,
            at: IndexPath(item: 0, section: 0)
        ) as? MyCouponHeaderView else { return }
        
        if cellIdentifier == headerView.tabFilterCell {
            isLoadingData = true
            collectionView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
                guard let self = self else { return }
                self.isLoadingData = false
                collectionView.reloadData()
            }
        }
    }
}
