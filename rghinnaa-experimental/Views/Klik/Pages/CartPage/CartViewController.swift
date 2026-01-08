//
//  CartViewController.swift
//  KlikIDM-DS-UiKit
//
//  Created by Rizka Ghinna Auliya on 13/05/25.
//

import UIKit
import KlikIDM_DS
import Lottie

class CartViewController: UIViewController {
    
    @IBOutlet var containerPromoGift: UIView!
    @IBOutlet var containerInsidePromoGift: UIView!
    @IBOutlet var containerStickPromoGift: UIView!
    @IBOutlet var containerInsideStickPromoGift: UIView!
    @IBOutlet var containerCoupon: UIView!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var btnBack: UIButton!
    
    @IBOutlet var loadingPromoTop: Skeleton!
    @IBOutlet var loadingPromo: Skeleton!
    @IBOutlet var ltConfetti: LottieAnimationView!
    @IBOutlet var ivConfetti: UIImageView!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblRealPrice: UILabel!
    @IBOutlet weak var btnStepper: ButtonStepper!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var lblTotalAllPrice: UILabel!
    
    var productPrice = 2000
    var productKartonPrice = 1800
    var productRealPrice = 4000
    var productQty = 0
    
    private var quantityInPieces = 0
    private var totalPrice = 0
    private var price = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        setupButtonStepper()
        
        updatePrice()
        lblRealPrice.attributedText = productRealPrice.formatRupiah().strikethrough()
        lblPrice.text = price.formatRupiah()
        lblTotalPrice.text = totalPrice.formatRupiah()
        lblTotalAllPrice.text = totalPrice.formatRupiah()
        
        scrollView.delegate = self
        
        setupLoadingView()
        
        containerStickPromoGift.isHidden = true
        setupPromoGiftContainers()
        
        btnBack.setTitle("", for: .normal)
        
        let blueGradient = [
            UIColor.white ?? .systemGray,
            UIColor.blue20 ?? .systemBlue
        ]
        
        containerCoupon.setGradientBackground(blueGradient, cornerRadius: 12, corners: [.topLeft, .topRight], borderWidth: 1, borderColor: UIColor.blue50)
    }
    
    private func setupButtonStepper() {
        btnStepper.delegate = self
        
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
    
    private func countTotalPrice(qty: Int) -> Int {
        let total = qty * productPrice
        return total
    }
    
    private func countTotalKartonPrice(qty: Int) -> Int {
        let total = qty * productKartonPrice
        return total
    }
    
    private func updatePrice() {
        quantityInPieces = productQty % 24
        totalPrice = countTotalPrice(qty: quantityInPieces) + countTotalKartonPrice(qty: (productQty-quantityInPieces))
        price = totalPrice / productQty
    }
    
    private func setupPromoGiftContainers() {
        containerStickPromoGift.layer.shadowOpacity = 0.15
        containerStickPromoGift.layer.shadowOffset = CGSize(width: 0, height: 5)
        containerStickPromoGift.layer.shadowRadius = 3
    }
    
    private func setupLoadingView() {
        loadingPromoTop.isHidden = false
        loadingPromo.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in guard let self = self else { return }
            loadingPromoTop.isHidden = true
            loadingPromo.isHidden = true
        }
    }
    
    private func setupConfetti() {
        ivConfetti.isHidden = false
        ivConfetti.alpha = 0
        
        ltConfetti.animation = LottieAnimation.named("confetti")
        ltConfetti.contentMode = .scaleAspectFit
        ltConfetti.loopMode = .repeat(2)
        
        ltConfetti.play()
        
        if let animation = ltConfetti.animation {
            let totalDuration = animation.duration * 2
            let showImageAt = totalDuration * 0.55
            
            DispatchQueue.main.asyncAfter(deadline: .now() + showImageAt) { [weak self] in
                UIView.animate(withDuration: 0.5, animations: {
                    self?.ivConfetti.alpha = 1.0
                        })
            }
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startConfetti(_ sender: Any) {
        setupConfetti()
    }
}

extension CartViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        hideView()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            handleScrollStop(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        handleScrollStop(scrollView)
    }
    
    private func hideView() {
        UIView.animate(withDuration: 0.2) {
            self.containerStickPromoGift.transform = CGAffineTransform(translationX: 0, y: -self.containerStickPromoGift.frame.height)
            self.containerCoupon.transform = CGAffineTransform(translationX: 0, y: self.containerCoupon.frame.height)
        }
    }
    
    private func handleScrollStop(_ scrollView: UIScrollView) {
        let scrollOffset = scrollView.contentOffset.y
        let promoGiftFrame = containerPromoGift.convert(containerPromoGift.bounds, to: scrollView)
        let transitionOffset = promoGiftFrame.origin.y + promoGiftFrame.height
        
        let resetTransform = CGAffineTransform.identity
        
        if scrollOffset > transitionOffset {
            containerStickPromoGift.isHidden = false
            UIView.animate(withDuration: 0.3) {
                self.containerStickPromoGift.transform = resetTransform
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.containerCoupon.transform = resetTransform
        }
    }
}

extension CartViewController: ButtonStepperDelegate {
    func didSelectButtonCollapsible(show isShow: Bool) {}
    
    func didSelectButtonMinus(qty quantity: Int) {
        productQty = quantity
        updatePrice()
        
        lblTotalPrice.text = totalPrice.formatRupiah()
        lblTotalAllPrice.text = totalPrice.formatRupiah()
        
        if productQty <= 24 {
            lblPrice.text = price.formatRupiah()
        }
    }
    
    func didSelectButtonPlus(qty quantity: Int) {
        productQty = quantity
        updatePrice()
        
        lblTotalPrice.text = totalPrice.formatRupiah()
        lblTotalAllPrice.text = totalPrice.formatRupiah()
        
        if productQty >= 24 {
            lblPrice.text = price.formatRupiah()
        }
    }
}
