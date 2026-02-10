//
//  ButtonViewController.swift
//  rghinnaa-experimental
//
//  Created by Yovita Handayiani on 11/01/26.
//

import UIKit
import KlikIDM_DS

class IconButtonViewController: UIViewController{
    
    @IBOutlet weak var btnTest1: IconButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTestButton()
    }
    
    private func setupTestButton() {
        // MARK: - Button Identity
        btnTest1.btnType = "secondary"        // primary | secondary | tertiary
        btnTest1.btnSize = "small"          // small | medium | large
        btnTest1.btnState = "rest"          // rest | pressed | focused | danger | disabled
        
//        // MARK: - Background (Solid)
//        btnTest1.bgColor = .clear
//        
//        // MARK: - Background (Gradient)
        btnTest1.bgColorStart = .systemPurple
        btnTest1.bgColorEnd = .systemPink
        btnTest1.bgColorOrientation = "vertical" // vertical | horizontal

        // MARK: - Corner & Border
        btnTest1.cornerRadius = 4
        btnTest1.borderWidth = 2
        btnTest1.borderColor = .white
        
        // MARK: - Icons
        btnTest1.icon = UIImage(named: "ic-cart")
        btnTest1.iconTint = .yellow
        btnTest1.iconSize = 24
        
        // MARK: - Padding
        btnTest1.paddingTop = 8
        btnTest1.paddingBottom = 8
        btnTest1.paddingLeading = 8
        btnTest1.paddingTrailing = 8
        
        // MARK: - Shadow
        btnTest1.shadowColor = .black
        btnTest1.shadowOpacity = 0.3
        btnTest1.shadowRadius = 6
        btnTest1.shadowOffset = CGSize(width: 0, height: 3)
    }
}
