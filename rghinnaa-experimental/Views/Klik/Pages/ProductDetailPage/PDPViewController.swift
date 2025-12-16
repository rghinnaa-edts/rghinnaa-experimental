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
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRealPrice: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var cardTotalType: CardSelectionList!
    @IBOutlet weak var badgeTotalImage: Badge!
    @IBOutlet weak var badgeDiscount: Badge!

    @IBOutlet weak var btnStepper: ButtonStepper!
    
    private var isBtnATCShow = false
    private var isCartons = false
    private var productPrice = 2000
    private var productRealPrice = 4000
    private var productQty = 0
    
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
        
        ivLocation.image = UIImage(named: "ic-marker-pin")?.withRenderingMode(.alwaysTemplate)
        ivLocation.tintColor = UIColor.blueDefault
        
        ivPlus.image = UIImage(named: "ic-plus")?.withRenderingMode(.alwaysTemplate)
        ivPlus.tintColor = UIColor.white
        
        ivTrash.image = UIImage(named: "ic-trash")?.withRenderingMode(.alwaysTemplate)
        ivTrash.tintColor = UIColor.grey50
        
        lblRealPrice.attributedText = productRealPrice.formatRupiah().strikethrough()
    }
    
    private func setupBadgeTotalImage() {
        badgeTotalImage.badgeTitle = "1/10"
        badgeTotalImage.badgeTitleColor = UIColor.grey60
        badgeTotalImage.badgeBackgroundColor = UIColor.white
        badgeTotalImage.badgeCornerRadius = 4
        badgeTotalImage.badgeBorderWidth = 1
        badgeTotalImage.badgeBorderColor = UIColor.grey30
    }
    
    private func setupBadgeDiscount() {
        badgeDiscount.badgeTitle = "15%"
        badgeDiscount.badgeTitleColor = UIColor.red30
        badgeDiscount.badgeBackgroundColor = UIColor.red10
        badgeDiscount.badgeCornerRadius = 4
    }
    
    private func setupCardTotalType() {
        cardTotalType.delegate = self
        
        cardTotalType.data = [
            CardSelectionModel(id: "1", title: "Satuan", description: "1Pcs"),
            CardSelectionModel(id: "2", title: "Karton", description: "24Pcs")
        ]
        cardTotalType.titleColor = UIColor.grey70
        cardTotalType.titleActiveColor = UIColor.blueDefault
        cardTotalType.descColor = UIColor.grey50
        cardTotalType.descActiveColor = UIColor.grey50
        cardTotalType.bgColor = UIColor.white
        cardTotalType.bgActiveColor = UIColor.white
        cardTotalType.borderColor = UIColor.grey20
        cardTotalType.borderActiveColor = UIColor.blueDefault
        cardTotalType.borderWidth = 1
        cardTotalType.cornerRadius = 8
    }
    
    private func setupButtonStepper() {
        btnStepper.delegate = self
        
        productQty = 1
        
        btnStepper.textQuantity = productQty
        btnStepper.textQuantityMultiple = 1
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

}

extension PDPViewController: CardSelectionDelegate, ButtonStepperDelegate {
    func didSelectCardSelection(at index: Int) {
        isCartons = index == 1
        btnStepper.textQuantityMultiple = !isCartons ? 1 : 24
        productPrice = !isCartons ? 2000 : 1800
        
        lblPrice.text = productPrice.formatRupiah()
        lblTotalPrice.text = countTotalPrice(qty: productQty).formatRupiah()
    }
    
    func didSelectButtonMinus(qty quantity: Int) {
        productQty = quantity
        isBtnATCShow = productQty < 1
        showHideButtonATC()
        
        lblTotalPrice.text = countTotalPrice(qty: productQty).formatRupiah()
    }
    
    func didSelectButtonPlus(qty quantity: Int) {
        productQty = quantity
        
        lblTotalPrice.text = countTotalPrice(qty: productQty).formatRupiah()
    }
}
