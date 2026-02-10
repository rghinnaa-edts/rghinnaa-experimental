//
//  CardMyCouponViewController.swift
//  rghinnaa-experimental
//
//  Created by Yovita Handayiani on 11/01/26.
//

import UIKit
import KlikIDM_DS

class CardMyCouponViewController: UIViewController, CardMyCouponDelegate {
    
    @IBOutlet weak var cmcTest1: CardMyCoupon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTestCardMyCoupon()
    }
    
    private func setupTestCardMyCoupon() {
        // MARK: - Text
        cmcTest1.title = "My Coupon"
        cmcTest1.titleColor = .blue
        
        cmcTest1.desc = "Valid until 31 Dec 2026"
        cmcTest1.descColor = .blue
        
        // MARK: - Background
        cmcTest1.isLiquidGlassBg = false
        cmcTest1.bgColor = UIColor.systemIndigo.withAlphaComponent(0.9)
        
        // MARK: - Leading Icon
        cmcTest1.iconLeading = UIImage(systemName: "ticket.fill")
        cmcTest1.iconTintLeading = .white
        cmcTest1.iconBgTintLeading = .blue
        
        // MARK: - Trailing Icon
        cmcTest1.iconTrailing = UIImage(systemName: "chevron.right")
        cmcTest1.iconTintTrailing = .blue
        
        // MARK: - Corner Radius
        cmcTest1.cornerRadius = 12
        
        // MARK: - Badge
        cmcTest1.isShowBadge = true
        cmcTest1.badgeLabel = "1"
        cmcTest1.badgeBgColor = .blue
        cmcTest1.badgeBorderWidth = 1
        cmcTest1.badgeBorderColor = .white
        cmcTest1.isBadgeSkeleton = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.cmcTest1.isBadgeSkeleton = false
        }
                
        // MARK: - Delegate (optional test)
        cmcTest1.delegate = self
    }
    
    func didSelectCard(_ card: CardMyCoupon) {
        print("CardMyCoupon tapped")
    }
}
