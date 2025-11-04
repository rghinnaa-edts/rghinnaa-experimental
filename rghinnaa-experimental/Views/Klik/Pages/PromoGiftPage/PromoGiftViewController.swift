//
//  PromoGiftViewController.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 09/05/25.
//

import UIKit
import KlikIDM_DS

class PromoGiftViewController: UIViewController {
    
    @IBOutlet var vTabTop: TabQuadRound!
    @IBOutlet var vTab: TabDefault!
    @IBOutlet var vDivider: UIView!
    @IBOutlet var vATC: UIView!
    @IBOutlet var btnATC: UIButton!
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var collectionContent: UICollectionView!
    @IBOutlet var loadingView: UIView!
    @IBOutlet var vCart: UIView!
    @IBOutlet var ivCart: UIImageView!
    @IBOutlet var lblRequired: UILabel!
    
    var selectedTabIndex = 0
    var tabItems: [TabQuadRoundModel] = []
    var items1: [PromoGiftModel] = []
    var items2: [PromoGiftModel] = []
    
    private var btnATCToBottom: NSLayoutConstraint?
    private var btnATCToLabelRequired: NSLayoutConstraint?
    private var lblRequiredConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        setupSkeleton()
        
        setupTabTop()
        setupTab()
        setupCollectionContent()
        setupATC()
        
        btnBack.setTitle("", for: .normal)
        btnBack.setImage(btnBack.image(for: .normal)?.withRenderingMode(.alwaysTemplate), for: .normal)
        btnBack.tintColor = UIColor.white
        
        setupConstraints()
        hideLabelRequired()
    }
    
    private func setupSkeleton() {
        loadingView.isHidden = false

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self else { return }

            loadingView.isHidden = true
        }
    }
    
    private func setupTabTop() {
        vTabTop.setData(tabItems)
        vTabTop.delegate = self
        vTabTop.tabBackgroundColor = UIColor.red30
        vTabTop.tabBackgroundActiveColor = UIColor.purple
        vTabTop.tabTextColor = UIColor.grey20
        vTabTop.tabTextActiveColor = UIColor.white
    }
    
    private func setupTab() {
        vTab.layer.shadowOpacity = 0.15
        vTab.layer.shadowOffset = CGSize(width: 0.0, height: 5.0)
        vTab.layer.shadowRadius = 3
        
        vTab.delegate = self
        
        vTab.registerCellType(TabDefaultCell.self, withIdentifier: "TabDefaultCell")
        vTab.setData(getCurrentContentItems().map { $0.chip })
        
        vTab.enableDynamicWidth()
        vTab.selectDefaultChip()
    }
    
    private func updateTabSelection() {
        vTab.data = getCurrentContentItems().map { $0.chip }
        vTab.selectDefaultChip()
    }
    
    private func setupATC() {
        vATC.layer.shadowOpacity = 0.15
        vATC.layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
        vATC.layer.shadowRadius = 3
        
        btnATC.layer.cornerRadius = 4
        
        vCart.layer.borderWidth = 1
        vCart.layer.borderColor = UIColor.blue50?.cgColor
        vCart.layer.cornerRadius = 4
        
        ivCart.image = ivCart.image?.withRenderingMode(.alwaysTemplate)
        ivCart.tintColor = UIColor.blue50
    }
    
    private func setupCollectionContent() {
        collectionContent.delegate = self
        collectionContent.dataSource = self
        
        let nib = UINib(nibName: "PromoContentCell", bundle: nil)
        collectionContent.register(nib, forCellWithReuseIdentifier: PromoContentCell.identifier)
        
        let firstItemPath = IndexPath(item: 0, section: 0)
        if !getCurrentContentItems().isEmpty {
            collectionContent.scrollToItem(at: firstItemPath, at: .centeredHorizontally, animated: false)
        }
        
        collectionContent.reloadData()
    }
    
    private func getCurrentContentItems() -> [PromoGiftModel] {
        return selectedTabIndex == 0 ? items1 : items2
    }
    
    private func showLoadingState() {
        loadingView.isHidden = false
    }
    
    private func hideLoadingState() {
        loadingView.isHidden = true
    }
    
    private func setupConstraints() {
        btnATC.translatesAutoresizingMaskIntoConstraints = false
        lblRequired.translatesAutoresizingMaskIntoConstraints = false
        
        btnATCToBottom = btnATC.bottomAnchor.constraint(
            equalTo: view.safeAreaLayoutGuide.bottomAnchor,
            constant: -16
        )
        
        btnATCToLabelRequired = btnATC.bottomAnchor.constraint(
            equalTo: lblRequired.topAnchor,
            constant: -12
        )
        
        lblRequiredConstraints = [
            lblRequired.trailingAnchor.constraint(equalTo: vATC.trailingAnchor, constant: -16),
            lblRequired.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            lblRequired.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        ]
        
        hideLabelRequired()
    }

    private func hideLabelRequired() {
        NSLayoutConstraint.deactivate(lblRequiredConstraints)
        btnATCToLabelRequired?.isActive = false
        
        btnATCToBottom?.isActive = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.lblRequired.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            self.lblRequired.isHidden = true
            self.collectionContent.collectionViewLayout.invalidateLayout()
        }
    }

    private func showLabelRequired() {
        lblRequired.isHidden = false
        lblRequired.alpha = 0.0
        
        btnATCToBottom?.isActive = false
        NSLayoutConstraint.activate(lblRequiredConstraints)
        btnATCToLabelRequired?.isActive = true
        
        UIView.animate(withDuration: 0.3, animations: {
            self.lblRequired.alpha = 1.0
            self.view.layoutIfNeeded()
        }) { _ in
            self.collectionContent.collectionViewLayout.invalidateLayout()
        }
    }
    
    private func loadData() {
        tabItems = [
            TabQuadRoundModel(id: "1", title: "Tebus Murah", badge: 3),
            TabQuadRoundModel(id: "2", title: "Cuci Gudang 2025", badge: 1),
            TabQuadRoundModel(id: "3", title: "Hadiah Produk", badge: 3),
            TabQuadRoundModel(id: "4", title: "Get Kupon", badge: 1),
            TabQuadRoundModel(id: "5", title: "Tebus Murah", badge: 3),
            TabQuadRoundModel(id: "6", title: "Cuci Gudang", badge: 1)
        ]
        
        items1 = [
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "1",
                    title: "Fair Hadiah Sandy Punten Jangan di pake"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "2",
                    title: "Fair Pagi migelas (9-12) PANJANG SEKALI SEKALISEKALISEKALISEKALISEKALISEKALI"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "3",
                    title: "FAIR HADIAHHH"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "4",
                    title: "Gajian Indomearet (limited)"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "5",
                    title: "Sunsilk"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "6",
                    title: "Kusuka"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "7",
                    title: "Caplang"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "8",
                    title: "Es Teh"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "9",
                    title: "Lifebuoy"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "10",
                    title: "Pikachu"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "11",
                    title: "Indomie"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "12",
                    title: "Sakura"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "13",
                    title: "Yummychoice"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "14",
                    title: "Point Coffee"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "15",
                    title: "Indomaret Homebrand"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "16",
                    title: "Mister Donat"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "17",
                    title: "Aqua"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "18",
                    title: "Happydent"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "19",
                    title: "Sari Roti"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "20",
                    title: "Buah-Buahan"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "21",
                    title: "Nezuko"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "22",
                    title: "Tanjiro"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "23",
                    title: "Giyuu"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "24",
                    title: "Shinobu"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "25",
                    title: "Zenitsu"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "26",
                    title: "Inosuke"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "27",
                    title: "Muzan"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "28",
                    title: "Douma"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "29",
                    title: "One Piece"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "30",
                    title: "Naruto"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "31",
                    title: "Pokemon"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "32",
                    title: "Huawei"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-paragon-fair"),
                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
                    isEnable: true,
                    products: [])),
//            PromoGiftModel(
//                chip: TabDefaultModel(
//                    id: "5",
//                    title: "Teh Pucuk Fair"),
//                content: PromoContentModel(
//                    banner: UIImage(named: "img-paragon-fair"),
//                    title: "Belanja All Item PARAGON FAIR Senilai Rp50.000 Dapat Hadiah",
//                    isEnable: true,
//                    products: []))
        ]
        
        items2 = [
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "1",
                    title: "Toples Kaca Idaman Fair"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-toples-kaca"),
                    title: "Belanja All Item Klik Indomaret Senilai Rp50.000 Dapat Tebus Murah Rp5.000",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "2",
                    title: "Alat Makan Fair"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-toples-kaca"),
                    title: "Belanja All Item Klik Indomaret Senilai Rp50.000 Dapat Tebus Murah Rp5.000",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "3",
                    title: "Toples Kaca Idaman Fair"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-toples-kaca"),
                    title: "Belanja All Item Klik Indomaret Senilai Rp50.000 Dapat Tebus Murah Rp5.000",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "4",
                    title: "Alat Makan Fair 2"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-toples-kaca"),
                    title: "Belanja All Item Klik Indomaret Senilai Rp50.000 Dapat Tebus Murah Rp5.000",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "5",
                    title: "Toples Kaca Idaman Fair 2"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-toples-kaca"),
                    title: "Belanja All Item Klik Indomaret Senilai Rp50.000 Dapat Tebus Murah Rp5.000",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "6",
                    title: "Alat Makan Fair 3"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-toples-kaca"),
                    title: "Belanja All Item Klik Indomaret Senilai Rp50.000 Dapat Tebus Murah Rp5.000",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "7",
                    title: "Toples Kaca Idaman Fair 3"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-toples-kaca"),
                    title: "Belanja All Item Klik Indomaret Senilai Rp50.000 Dapat Tebus Murah Rp5.000",
                    isEnable: true,
                    products: [])),
            PromoGiftModel(
                chip: TabDefaultModel(
                    id: "8",
                    title: "Alat Makan Fair 4"),
                content: PromoContentModel(
                    banner: UIImage(named: "img-toples-kaca"),
                    title: "Belanja All Item Klik Indomaret Senilai Rp50.000 Dapat Tebus Murah Rp5.000",
                    isEnable: true,
                    products: []))
        ]
    }
    
    @IBAction func btnBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnATC(_ sender: Any) {
        showLabelRequired()
    }
}

extension PromoGiftViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if selectedTabIndex == 0 {
            return items1.count
        } else {
            return items2.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionContent.dequeueReusableCell(withReuseIdentifier: PromoContentCell.identifier, for: indexPath) as! PromoContentCell
        
        let contentItem = getCurrentContentItems().map { $0.content }
        
        cell.setup(contentItem[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionContent.frame.width, height: collectionContent.frame.height)
    }
    
}

extension PromoGiftViewController: TabDefaultDelegate {
    func didSelectTabDefault(at index: Int, withId id: String) {
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionContent.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension PromoGiftViewController: TabQuadRoundDelegate {
    func didSelectTabQuadRound(at index: Int, withId id: String) {
        selectedTabIndex = index
        
        updateTabSelection()
        collectionContent.reloadData()
        
        let firstItemPath = IndexPath(item: 0, section: 0)
        if !getCurrentContentItems().isEmpty {
            collectionContent.scrollToItem(at: firstItemPath, at: .centeredHorizontally, animated: true)
        }
    }
}
