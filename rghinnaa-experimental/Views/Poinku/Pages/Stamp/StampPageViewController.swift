//
//  StampPageViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 04/03/25.
//

import UIKit

class StampPageViewController: UIViewController {
    
    @IBOutlet var lblStamp: UILabel!
    @IBOutlet var stampChipBucket: UIView!
    @IBOutlet var collectionBucket: UICollectionView!
    @IBOutlet var collectionProduct: UICollectionView!
    
    @IBOutlet var cm1: UIView!
    @IBOutlet var cm2: UIView!
    @IBOutlet var cm3: UIView!
    @IBOutlet var cm4: UIView!
    
    var products: [Product] = []
    var bucket: [ChipBucket] = []
    var currentlySelectedBucketId: String? = nil
    var isUserSelectingBucket: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadProducts()
        loadChipBucket()
        
        DispatchQueue.main.async {
            self.showCoachmark()
        }
    }
    
    private func setupUI() {
        setupChipView()
        setupProductView()
        
        lblStamp.font = Font.B2.Small.font
        lblStamp.textColor = .black
        
        stampChipBucket.backgroundColor = .white
        stampChipBucket.backgroundColor = .white
        stampChipBucket.layer.shadowColor = UIColor.grey50.cgColor
        stampChipBucket.layer.shadowOpacity = 0.15
        stampChipBucket.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        stampChipBucket.layer.shadowRadius = 3.0
        stampChipBucket.layer.masksToBounds = false
    }
    
    func showCoachmark() {
        cm1.isHidden = false
        cm2.isHidden = false
        cm3.isHidden = false
        cm4.isHidden = false
        
        let coachmark = Coachmark(frame: .zero)

        coachmark.configureSteps(steps: [
            Coachmark.StepConfiguration(
                title: "Cek Jumlah Stamp yang Kamu Punya",
                description: "Tap pada brand yang ada untuk langsung menuju kumpulan kupon yang kamu inginkan.",
                targetView: cm1
            ),
            Coachmark.StepConfiguration(
                title: "Ini Stamp Punya Kamu di Masing-Masing Brand",
                description: "Masing-masing brand punya Stampnya sendiri. Ini adalah jumlah Stamp yang kamu punya pada brand terkait.",
                targetView: cm2
            ),
            Coachmark.StepConfiguration(
                title: "Bisa Langsung Tukar Stamp jadi i-Kupon",
                description: "Ayo langsung tukar Stamp jadi i-Kupon dari sini. Kalau mau lihat lebih lengkap, coba tap pada gambar kupon.",
                targetView: cm3
            ),
            Coachmark.StepConfiguration(
                title: "Lihat Penukaran pada Brand Selengkapnya",
                description: "Lihat syarat, ketentuan, dan semua i-Kupon yang ditawarkan oleh setiap brand lewat sini.",
                targetView: cm4
            )
        ])
        
        coachmark.onDismiss = { [weak self] in
            self?.cm1.isHidden = true
            self?.cm2.isHidden = true
            self?.cm3.isHidden = true
            self?.cm4.isHidden = true
        }

        coachmark.show()
    }
    
    func setupChipView() {
        let brandFlowLayout = UICollectionViewFlowLayout()
        brandFlowLayout.scrollDirection = .horizontal
        brandFlowLayout.minimumInteritemSpacing = 12
        brandFlowLayout.minimumLineSpacing = 12
        brandFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        brandFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionBucket.collectionViewLayout = brandFlowLayout
        collectionBucket.backgroundColor = .clear
        collectionBucket.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionBucket.showsHorizontalScrollIndicator = false
        collectionBucket.alwaysBounceHorizontal = true
        collectionBucket.decelerationRate = .normal
        collectionBucket.register(StampBrand.self, forCellWithReuseIdentifier: "StampBrand")
        
        collectionBucket.delegate = self
        collectionBucket.dataSource = self
    }
    
    func setupProductView() {
        let productFlowLayout = UICollectionViewFlowLayout()
        productFlowLayout.scrollDirection = .vertical
        productFlowLayout.minimumInteritemSpacing = 16
        productFlowLayout.minimumLineSpacing = 16
        productFlowLayout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        collectionProduct.collectionViewLayout = productFlowLayout
        collectionProduct.backgroundColor = UIColor.grey10
        collectionProduct.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionProduct.register(StampBrandProduct.self, forCellWithReuseIdentifier: "StampBrandProduct")
        
        collectionProduct.delegate = self
        collectionProduct.dataSource = self
    }
    
    func loadProducts() {
        products = [
            Product(id: "1", image: "indomaret", name: "Indomaret Festival", currentStamp: "32"),
            Product(id: "2", image: "unilever", name: "Gebyar Unilever Indonesia", currentStamp: "8"),
            Product(id: "3", image: "danone", name: "Danone Festival", currentStamp: "10"),
            Product(id: "4", image: "mister_donut", name: "Mister Donut Fest", currentStamp: "10"),
            Product(id: "5", image: "indomaret", name: "Indomaret Festival", currentStamp: "32"),
            Product(id: "6", image: "unilever", name: "Gebyar Unilever Indonesia", currentStamp: "8"),
            Product(id: "7", image: "danone", name: "Danone Festival", currentStamp: "10"),
            Product(id: "8", image: "mister_donut", name: "Mister Donut Fest", currentStamp: "10")
        ]
        
        collectionProduct.reloadData()
    }
    
    func loadChipBucket() {
        bucket = [
            ChipBucket(id: "1", image: "indomaret", currentStamp: "32"),
            ChipBucket(id: "2", image: "unilever", currentStamp: "8"),
            ChipBucket(id: "3", image: "danone", currentStamp: "0"),
            ChipBucket(id: "4", image: "mister_donut", currentStamp: "0"),
            ChipBucket(id: "5", image: "indomaret", currentStamp: "32"),
            ChipBucket(id: "6", image: "unilever", currentStamp: "8"),
            ChipBucket(id: "7", image: "danone", currentStamp: "0"),
            ChipBucket(id: "8", image: "mister_donut", currentStamp: "0")
        ]
        
        collectionBucket.reloadData()
        
        DispatchQueue.main.async {
            self.selectDefaultChipBucket()
        }
    }
    
    func selectDefaultChipBucket() {
        guard !bucket.isEmpty else { return }
        
        let defaultSelectedIndexPath = IndexPath(item: 0, section: 0)
        currentlySelectedBucketId = bucket[0].id
        
        if let cell = collectionBucket.cellForItem(at: defaultSelectedIndexPath) as? StampBrand {
            for index in 0..<bucket.count {
                let indexPath = IndexPath(item: index, section: 0)
                if let otherCell = collectionBucket.cellForItem(at: indexPath) as? StampBrand {
                    otherCell.isSelectedState = false
                }
            }
            
            cell.isSelectedState = true
        }
    }
    
    func selectChipBucketWithId(_ bucketId: String, centerInView: Bool = true) {
        if currentlySelectedBucketId == bucketId {
            return
        }
        
        currentlySelectedBucketId = bucketId
        
        if let bucketIndex = bucket.firstIndex(where: { $0.id == bucketId }) {
            let bucketIndexPath = IndexPath(item: bucketIndex, section: 0)
            
            for index in 0..<bucket.count {
                let indexPath = IndexPath(item: index, section: 0)
                if let cell = collectionBucket.cellForItem(at: indexPath) as? StampBrand {
                    cell.isSelectedState = (index == bucketIndex)
                }
            }
            
            if centerInView && !isUserSelectingBucket {
                if let flowLayout = collectionBucket.collectionViewLayout as? UICollectionViewFlowLayout {
                    let cellFrame = flowLayout.layoutAttributesForItem(at: bucketIndexPath)?.frame ?? .zero
                    let contentOffsetX = cellFrame.midX - (collectionBucket.bounds.width / 2)
                    let adjustedOffsetX = max(0, min(contentOffsetX,
                                                     collectionBucket.contentSize.width - collectionBucket.bounds.width))
                    collectionBucket.setContentOffset(CGPoint(x: adjustedOffsetX, y: 0), animated: true)
                }
            }
        }
    }
}

struct Product {
    let id: String
    let image: String
    let name: String
    let currentStamp: String
}

struct ChipBucket {
    let id: String
    let image: String
    let currentStamp: String
}

extension StampPageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionBucket {
            return bucket.count
        } else {
            return products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionBucket {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StampBrand", for: indexPath) as! StampBrand
            
            let bucket = bucket[indexPath.item]
            cell.loadBrand(
                brandImage: bucket.image,
                totalStamps: bucket.currentStamp
            )
            
            cell.isSelectedState = (bucket.id == currentlySelectedBucketId)

            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StampBrandProduct", for: indexPath) as! StampBrandProduct
            
            let product = products[indexPath.item]
            cell.loadBrandProduct(
                brandName: product.name,
                brandImage: product.image,
                totalStamps: product.currentStamp + " Stamp"
            )
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        if collectionView == collectionBucket {
            let collectionViewWidth = collectionView.bounds.width
            let estimatedCellWidth = Int(collectionViewWidth * 0.4)
            
            let height = 44
            
            return CGSize(width: estimatedCellWidth, height: height)
            
        } else {
            let productCell = StampBrandProduct()
            
            let width = productCell.calculateWidth()
            let height = productCell.calculateHeight(for: CGFloat.greatestFiniteMagnitude)
            
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionBucket {
            isUserSelectingBucket = true
            
            for index in 0..<bucket.count {
                let deselectIndexPath = IndexPath(item: index, section: 0)
                if let cell = collectionBucket.cellForItem(at: deselectIndexPath) as? StampBrand {
                    cell.isSelectedState = false
                }
            }
            
            if let cell = collectionBucket.cellForItem(at: indexPath) as? StampBrand {
                cell.isSelectedState = true
            }
            
            let selectedBucket = bucket[indexPath.item]
            currentlySelectedBucketId = selectedBucket.id
            
            if let flowLayout = collectionBucket.collectionViewLayout as? UICollectionViewFlowLayout {
                let cellFrame = flowLayout.layoutAttributesForItem(at: indexPath)?.frame ?? .zero
                
                let contentOffsetX = cellFrame.midX - (collectionBucket.bounds.width / 2)
                
                let adjustedOffsetX = max(0, min(contentOffsetX,
                                                 collectionBucket.contentSize.width - collectionBucket.bounds.width))
                
                collectionBucket.setContentOffset(CGPoint(x: adjustedOffsetX, y: 0), animated: true)
            }
        
            scrollToSelectedProduct(for: selectedBucket)

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.isUserSelectingBucket = false
            }
            
        } else if collectionView == collectionProduct {
            _ = products[indexPath.item]
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionProduct && !isUserSelectingBucket {
            updateBrandSelectionScrollProducts()
        }
    }
    
    private func scrollToSelectedProduct(for bucket: ChipBucket) {
        if let firstMatchingProductIndex = products.firstIndex(where: { $0.id == bucket.id }) {
            let firstProductIndexPath = IndexPath(item: firstMatchingProductIndex, section: 0)
            
            DispatchQueue.main.async {
                self.collectionProduct.scrollToItem(at: firstProductIndexPath, at: .top, animated: true)
            }
        } else {
            DispatchQueue.main.async {
                self.collectionProduct.setContentOffset(.zero, animated: true)
            }
        }
    }
    
    private func updateBrandSelectionScrollProducts() {
        guard let visibleCells = collectionProduct.visibleCells as? [StampBrandProduct],
              !visibleCells.isEmpty else {
            return
        }
        
        let cell = visibleCells.sorted { (cell1, cell2) -> Bool in
            let cellFrame1 = collectionProduct.convert(cell1.frame, to: collectionProduct.superview)
            let cellFrame2 = collectionProduct.convert(cell2.frame, to: collectionProduct.superview)
            return cellFrame1.origin.y < cellFrame2.origin.y
        }
        
        if let topCell = cell.first,
           let indexPath = collectionProduct.indexPath(for: topCell) {
            
            let topProduct = products[indexPath.item]
            
            if let matchingBrand = bucket.first(where: { $0.id == topProduct.id }) {
                selectChipBucketWithId(matchingBrand.id, centerInView: true)
            }
        }
    }
}

