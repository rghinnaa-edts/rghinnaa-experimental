//
//  CardMyCouponViewController.swift
//  rghinnaa-experimental
//
//  Created by Yovita Handayiani on 11/01/26.
//

import UIKit
import KlikIDM_DS

class CardMyCouponViewController: UIViewController, CardMyCouponDelegate {
    @IBOutlet weak var myCoupon: CardMyCoupon!
    private var a = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTestCardMyCoupon()
    }
    
    private func setupTestCardMyCoupon() {
        myCoupon.title = "My Coupon"
        myCoupon.desc = "Valid until 31 Dec 2026"
        myCoupon.isLiquidGlassBg = false
        myCoupon.bgColor = UIColor.yellow40
        myCoupon.iconLeading = UIImage(systemName: "ticket.fill")
        myCoupon.iconTintLeading = .white
        myCoupon.iconBgTintLeading = .blue
        myCoupon.iconTrailing = UIImage(systemName: "chevron.right")
        myCoupon.cornerRadius = 12
        myCoupon.configureBadge{ badge in
            badge.isHidden = false
            badge.label = "1"
            badge.bgColor = .brown
            badge.borderWidth = 1
            badge.borderColor = .white
            badge.isSkeleton = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                badge.isSkeleton = false
            }
        }
        myCoupon.delegate = self
    }
    
    func didSelectCard(_ card: CardMyCoupon) {
        print("CardMyCoupon tapped")
        myCoupon.configureBadge{ badge in
            a+=1
            badge.label = "\(a)"
        }
    }
}
