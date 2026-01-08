//
//  PDPViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 08/12/25.
//

import UIKit
import KlikIDM_DS

class PDPViewController: UIViewController {
    
    @IBOutlet weak var ivLocation: UIImageView!
    @IBOutlet weak var ivPlus: UIImageView!
    @IBOutlet weak var ivTrash: UIImageView!
    @IBOutlet weak var btnATC: UIView!
    @IBOutlet weak var containerPrice: UIView!
    @IBOutlet weak var containerBottom: UIView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRealPrice: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var cardTotalType: CardSelectionList!
    @IBOutlet weak var badgeTotalImage: Badge!
    @IBOutlet weak var badgeDiscount: Badge!
    @IBOutlet weak var btnCart: UIImageView!
    
    @IBOutlet weak var btnStepper: ButtonStepper!
    
    var productQuantity: Int = 0
    
    private var isBtnATCShow = false
    private var isCartons = false
    private var productPrice = 2000
    private var productRealPrice = 4000
    private var productQty = 0
    private var data = [CardSelectionModel]()
    
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
        setupBadgeTotalImage()
        setupBadgeDiscount()
        setupCardTotalType()
        setupButtonStepper()
        setupButtonATC()
        setupButtonCart()
        
        ivLocation.image = UIImage(named: "ic-marker-pin")?.withRenderingMode(.alwaysTemplate)
        ivLocation.tintColor = UIColor.blueDefault
        
        ivPlus.image = UIImage(named: "ic-plus")?.withRenderingMode(.alwaysTemplate)
        ivPlus.tintColor = UIColor.white
        
        ivTrash.image = UIImage(named: "ic-trash")?.withRenderingMode(.alwaysTemplate)
        ivTrash.tintColor = UIColor.grey50
        
        lblRealPrice.attributedText = productRealPrice.formatRupiah().strikethrough()
    }
    
    private func setupBadgeTotalImage() {
        badgeTotalImage.title = "1/10"
        badgeTotalImage.titleColor = UIColor.grey60
        badgeTotalImage.bgColor = UIColor.white
        badgeTotalImage.cornerRadius = 4
        badgeTotalImage.borderWidth = 1
        badgeTotalImage.borderColor = UIColor.grey30
    }
    
    private func setupBadgeDiscount() {
        badgeDiscount.title = "15%"
        badgeDiscount.titleColor = UIColor.red30
        badgeDiscount.bgColor = UIColor.red10
        badgeDiscount.cornerRadius = 4
    }
    
    private func setupCardTotalType() {
        cardTotalType.delegate = self
        
        data = [
            CardSelectionModel(id: "1", title: "Satuan", description: "1Pcs", isEnabled: true),
            CardSelectionModel(id: "2", title: "Karton", description: "24Pcs", isEnabled: true)
        ]
        
        cardTotalType.data = data
        cardTotalType.titleColor = UIColor.grey70
        cardTotalType.titleActiveColor = UIColor.blueDefault
        cardTotalType.descColor = UIColor.grey50
        cardTotalType.descActiveColor = UIColor.grey50
        cardTotalType.bgColor = UIColor.white
        cardTotalType.bgActiveColor = UIColor.white
        cardTotalType.cornerRadius = 8
        cardTotalType.borderColor = UIColor.grey20
        cardTotalType.borderActiveColor = UIColor.blueDefault
        cardTotalType.borderWidth = 1
        cardTotalType.shadowOpacity = 0.2
        cardTotalType.shadowOffset = CGSize(width: 0, height: 1)
        cardTotalType.shadowRadius = 2
    }
    
    private func setupButtonStepper() {
        btnStepper.delegate = self
        
        let index = data.firstIndex(where: { $0.isEnabled })
        isCartons = index == 1
        
        productQty = (productQuantity <= 0) ? (!isCartons ? 1 : 24) : productQuantity
        lblTotalPrice.text = countTotalPrice(qty: productQty).formatRupiah()
        
        btnStepper.textQuantity = productQty
        btnStepper.textQuantityMultiple = !isCartons ? 1 : 24
        btnStepper.textQuantityColor = UIColor.grey70
        btnStepper.bgColor = UIColor.white
        btnStepper.btnMinusColor = UIColor.grey60
        btnStepper.btnMinusBackgroundColor = UIColor.white
        btnStepper.btnPlusColor = UIColor.white
        btnStepper.btnPlusBackgroundColor = UIColor.blueDefault
        btnStepper.borderWidth = 1
        btnStepper.borderColor = UIColor.grey30
    }
    
    private func setupButtonATC() {
        btnATC.layer.cornerRadius = 4
        
        let btnATCGesture = UITapGestureRecognizer(target: self, action: #selector(actionButtonATC))
        btnATC.addGestureRecognizer(btnATCGesture)
    }
    
    private func setupButtonCart() {
        let btnCartGesture = UITapGestureRecognizer(target: self, action: #selector(actionButtonCart))
        btnCart.addGestureRecognizer(btnCartGesture)
    }
    
    private func countTotalPrice(qty: Int) -> Int {
        let total = qty * productPrice
        return total
    }
    
    private func showHideButtonATC() {
        containerPrice.isHidden = isBtnATCShow
        btnATC.isHidden = !isBtnATCShow
    }
    
    @objc private func actionButtonATC() {
        isBtnATCShow = false
        showHideButtonATC()
        
        productQty = 1
        
        btnStepper.textQuantity = productQty
        lblTotalPrice.text = countTotalPrice(qty: productQty).formatRupiah()
    }
    
    @objc private func actionButtonCart() {
        let vc = UIStoryboard(name: "CartViewController", bundle: nil).instantiateViewController(withIdentifier: "CartPage") as! CartViewController
        
        vc.productQty = productQty
        
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func actionButtonBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

extension PDPViewController: CardSelectionDelegate, ButtonStepperDelegate {
    func didSelectCardSelection(at index: Int) {
        isCartons = index == 1
        btnStepper.textQuantityMultiple = !isCartons ? 1 : 24
        productPrice = !isCartons ? 2000 : 1800
        
        lblPrice.text = productPrice.formatRupiah()
        lblTotalPrice.text = countTotalPrice(qty: productQty).formatRupiah()
    }
    
    func didSelectButtonCollapsible(show isShow: Bool) {}
    
    func didSelectButtonMinus(qty quantity: Int) {
        productQty = quantity
        isBtnATCShow = productQty < 1
        showHideButtonATC()
        
        lblTotalPrice.text = countTotalPrice(qty: productQty).formatRupiah()
    }
    
    func didSelectButtonPlus(qty quantity: Int) {
        productQty = quantity
        
        lblTotalPrice.text = countTotalPrice(qty: productQty).formatRupiah()
        
        if isCartons {
            if productQty >= 24 {
                showToast(message: "Produk ini hanya bisa dibeli maksimal 24 per transaksi")
            }
        } else {
            if productQty >= 5 {
                showToast(message: "Produk yang kamu inginkan melebihi stok yang tersedia")
            }
        }
        
    }
    
    func showToast(message: String, font: UIFont = .systemFont(ofSize: 12.0)) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.minX + 16,
                                               y: self.containerBottom.frame.minY - 64,
                                               width: self.view.frame.size.width-32,
                                               height: 50))
        toastLabel.backgroundColor = UIColor.grey60
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        
    UIView.animate(withDuration: 1.0, delay: 2.0, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }) { _ in
            toastLabel.removeFromSuperview()
        }
    }
}
