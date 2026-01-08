//
//  SearchPageViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 11/12/25.
//

import UIKit
import KlikIDM_DS

class SearchViewController: UIViewController {
    
    @IBOutlet weak var vToolbar: UIView!
    @IBOutlet weak var vTabDeliveryType: TabDefault!
    @IBOutlet weak var vCart: UIView!
    @IBOutlet weak var vFilter: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    var data: [CardProductModel] = []
    private let staggeredLayout = StraggeredCollectionLayout()
    private var cartConstraint: NSLayoutConstraint!
    
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
        setupToolbar()
        setupTab()
        setupCart()
        setupFilter()
        setupCollectionView()
    }
    
    private func setupToolbar() {
        vToolbar.layer.shadowOpacity = 0.15
        vToolbar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        vToolbar.layer.shadowRadius = 3
    }
    
    private func setupTab() {
        vTabDeliveryType.registerCellType(TabDeliveryTypeCell.self, withIdentifier: "TabDeliveryTypeCell")
        vTabDeliveryType.delegate = self
        
        vTabDeliveryType.data = [
            TabDeliveryTypeModel(
                id: "1",
                title: "Xpress",
                desc: "2 Produk tersedia",
                icon: UIImage(named: "ic-xpress")
            ),
            TabDeliveryTypeModel(
                id: "2",
                title: "Xtra",
                desc: "2 Produk tersedia",
                icon: UIImage(named: "ic-xtra")
            )
        ]
        vTabDeliveryType.cellConfiguration = { cell, data, isSelected, index in
            guard let cell = cell as? TabDeliveryTypeCell else { return }
        
            cell.tabTitleActiveColor = index == 0 ? UIColor.brandXpress : UIColor.brandXtra
            cell.tabIndicatorColor = index == 0 ? UIColor.brandXpress : UIColor.brandXtra
            cell.tabTitleColor = UIColor.grey50
            cell.tabDescColor = UIColor.grey50
            cell.tabDescActiveColor = UIColor.black
            cell.tabBackgroundColor = .white
            cell.tabBackgroundActiveColor = .white
        }
        
        vTabDeliveryType.disableDynamicWidth()
        vTabDeliveryType.setSize(width: UIScreen.main.bounds.width/2, height: 51, horizontalPadding: 0)
        vTabDeliveryType.setItemPadding(topPadding: 0, leadingPadding: 0, bottomPadding: 0, trailingPadding: 0, itemSpacing: 0)
        vTabDeliveryType.selectDefaultTab()
    }
    
    private func setupCollectionView() {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumInteritemSpacing = 12
//        layout.minimumLineSpacing = 12
//        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//        
//        let totalSpacing = layout.sectionInset.left + layout.sectionInset.right + layout.minimumInteritemSpacing
//        let itemWidth = (UIScreen.main.bounds.width - totalSpacing) / 2
//        
//        layout.itemSize = CGSize(width: itemWidth, height: 300)
//        
//        collectionView.collectionViewLayout = layout
//        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        collectionView.delegate = self
//        collectionView.dataSource = self
        staggeredLayout.delegate = self
        staggeredLayout.configure(numberOfColumns: 2, cellPadding: 6)
        
        collectionView.collectionViewLayout = staggeredLayout
        collectionView.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CardProductCell.self, forCellWithReuseIdentifier: "CardProductCell")
        
        data = [
            CardProductModel(
                id: "1",
                image: UIImage(named:"aqua"),
                iconGiftBadge: UIImage(named: "ic-gift"),
                nameGiftBadge: "Gratis Hadiah",
                bgGiftBadge: UIColor.strongSuccess,
                name: "Aqua Air Mineral 600ml",
                price: 2000,
                discount: 15,
                realPrice: 4000,
                badgePromo2: true,
                badgePromo3: true,
                point: 0,
                stamp: 0
            ),
            CardProductModel(
                id: "2",
                image: UIImage(named:"aqua1l"),
                iconGiftBadge: UIImage(named: "ic-percent"),
                nameGiftBadge: "Banyak Lebih Hemat",
                bgGiftBadge: UIColor.strongError,
                name: "Aqua Life Air Mineral 1.1L",
                price: 8700,
                discount: 0,
                realPrice: 8700,
                badgePromo2: false,
                badgePromo3: true,
                point: 100,
                stamp: 100
            ),
            CardProductModel(
                id: "3",
                image: UIImage(named:"idmmineral"),
                iconGiftBadge: UIImage(named: "ic-bundling"),
                nameGiftBadge: "Paket Bundling",
                bgGiftBadge: UIColor.strongWarning,
                name: "Indomaret Air Mineral 600Ml",
                price: 5200,
                discount: 50,
                realPrice: 30000,
                badgePromo2: false,
                badgePromo3: false,
                point: 0,
                stamp: 0
            ),
            CardProductModel(
                id: "4",
                image: UIImage(named:"aqua750ml"),
                iconGiftBadge: UIImage(named: "ic-percent"),
                nameGiftBadge: "Banyak Lebih Hemat",
                bgGiftBadge: UIColor.red,
                name: "Aqua Air Mineral Click N Go 750Ml",
                price: 6600,
                discount: 0,
                realPrice: 6600,
                badgePromo2: false,
                badgePromo3: false,
                point: 0,
                stamp: 0
            )
        ]
    }
    
    private func setupCart() {
        vCart.layer.cornerRadius = 4
        
        cartConstraint = vCart.heightAnchor.constraint(equalToConstant: 44)
        cartConstraint.isActive = true
        cartConstraint.constant = 0
    }
    
    private func setupFilter() {
        vFilter.layer.cornerRadius = vFilter.frame.height / 2
        vFilter.layer.borderWidth = 1
        vFilter.layer.borderColor = UIColor.grey30?.cgColor
    }
    
    @IBAction func actionButtonBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardProductCell", for: indexPath) as! CardProductCell
        
        cell.loadData(data: data[indexPath.row])
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "PDPViewController", bundle: nil).instantiateViewController(withIdentifier: "PDPPage") as! PDPViewController
            
        if let cell = collectionView.cellForItem(at: indexPath) as? CardProductCell {
            vc.productQuantity = cell.currentQuantity
        }
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: TabDefaultDelegate, CardProductCellDelegate {
    func didSelectTabDefault(at index: Int, withId id: String) {
        
    }
    
    func didSelectButtonCollapsible(show isShow: Bool) {
//        cartConstraint = vCart.heightAnchor.constraint(equalToConstant: 44)
//        cartConstraint.isActive = true
//        cartConstraint.constant = 44
    }
}

extension SearchViewController: StraggeredCollectionLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, width: CGFloat) -> CGFloat {
//        let cell = ProductCardCell()
//        cell.frame = CGRect(x: 0, y: 0, width: width, height: 0)
//        cell.loadData(data: data[indexPath.row])
//
//        let targetSize = CGSize(width: width, height: UIView.layoutFittingCompressedSize.height)
//        let size = cell.contentView.systemLayoutSizeFitting(
//            targetSize,
//            withHorizontalFittingPriority: .required,
//            verticalFittingPriority: .fittingSizeLevel
//        )
//        
//        return size.height
        
        let heights: [CGFloat] = [310, 300, 270, 250]
        return heights[indexPath.row % heights.count]
    }
}
