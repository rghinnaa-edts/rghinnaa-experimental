////
////  ButtonViewController.swift
////  rghinnaa-experimental
////
////  Created by Yovita Handayiani on 11/01/26.
////
//
//import UIKit
//import KlikIDM_DS
//
//class ButtonViewController: UIViewController{
//    @IBOutlet weak var btnTest1: KlikIDM_DSButton!
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupTestButton()
//    }
//    
//    private func setupTestButton() {
//        // MARK: - Button Identity
//        btnTest1.btnType = "secondary"        // primary | secondary | tertiary
//        btnTest1.btnSize = "small"          // small | medium | large
//        btnTest1.btnState = "rest"          // rest | pressed | focused | danger | disabled
//        
//        // MARK: - Label
//        btnTest1.label = "Test Button"
//        btnTest1.labelColor = .blue
//        
//        // MARK: Attributed text (optional – comment out label if testing this)
//        btnTest1.labelAttributed = NSAttributedString(
//            string: "Attributed",
//            attributes: [
//                .foregroundColor: UIColor.yellow,
//                .kern: 1.2
//            ]
//        )
//        
//        // MARK: - Font
//        btnTest1.fontName = ""              // empty = system font
//        btnTest1.fontSize = 16
//        btnTest1.fontWeight = "heavy"        // ultralight, thin, light, regular, medium, semibold, bold, heavy, black
//        
//        // MARK: - Background (Solid)
//        btnTest1.bgColor = .systemBlue
//        
//        // MARK: - Background (Gradient)
//        btnTest1.bgColorStart = .systemPurple
//        btnTest1.bgColorEnd = .systemPink
//        btnTest1.bgColorOrientation = "vertical" // vertical | horizontal
//
//        // MARK: - Corner & Border
//        btnTest1.cornerRadius = 12
//        btnTest1.borderWidth = 2
//        btnTest1.borderColor = .white
//        
//        // MARK: - Icons
//        btnTest1.iconLeading = UIImage(systemName: "star.fill")
//        btnTest1.iconTrailing = UIImage(systemName: "chevron.right")
//        btnTest1.iconTintLeading = .yellow
//        btnTest1.iconTintTrailing = .blue
//        btnTest1.iconSize = 20
//        btnTest1.iconSpacing = 10
//        
//        // MARK: - Padding
//        btnTest1.paddingTop = 12
//        btnTest1.paddingBottom = 12
//        btnTest1.paddingLeading = 16
//        btnTest1.paddingTrailing = 16
//        
//        // MARK: - Shadow
//        btnTest1.shadowColor = .black
//        btnTest1.shadowOpacity = 0.3
//        btnTest1.shadowRadius = 6
//        btnTest1.shadowOffset = CGSize(width: 0, height: 3)
//    }
//}
