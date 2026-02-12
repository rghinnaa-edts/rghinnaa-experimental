//
//  ChipViewController.swift
//  rghinnaa-experimental
//
//  Created by Yovita Handayiani on 11/01/26.
//

import UIKit
import KlikIDM_DS

class ChipViewController: UIViewController, ChipDelegate {
    @IBOutlet weak var chip1: KlikIDM_DSChip!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chip1.label = "Default Label"
        
//        let attributedText = NSMutableAttributedString(
//            string: "🔥 Promo Chip",
//            attributes: [
//                .font: UIFont.systemFont(ofSize: 14, weight: .bold),
//                .foregroundColor: UIColor.red
//            ]
//        )
//        
//        attributedText.addAttributes([
//            .foregroundColor: UIColor.blue,
//            .underlineStyle: NSUnderlineStyle.single.rawValue
//        ], range: NSRange(location: 3, length: 5))
//        
//        chip1.labelAttributed = attributedText
        
        // MARK: - Font Test
        chip1.fontName = ""                 // try custom font name here
        chip1.fontSize = 20
        chip1.fontWeight = "thin"       // ultralight, thin, light, regular, medium, semibold, bold, heavy, black
        
        // MARK: - Icon Test
        chip1.iconLeading = UIImage(systemName: "star.fill")
        chip1.iconTrailing = UIImage(systemName: "xmark.circle.fill")
        
        chip1.iconSize = 20
        chip1.iconSpacing = 8
        
        // MARK: - Color (Inactive)
        chip1.labelColor = .systemBlue
        chip1.bgColor = .systemGray6
        chip1.borderColor = .systemBlue
        
        chip1.iconTintLeading = .systemOrange
        chip1.iconBGColorLeading = .white
        
        chip1.iconTintTrailing = .systemRed
        chip1.iconBGColorTrailing = .white
        
        // MARK: - Color (Active)
        chip1.labelColorActive = .white
        chip1.bgColorActive = .systemBlue
        chip1.borderColorActive = .purple
        
        chip1.iconTintLeadingActive = .systemPink
        chip1.iconBGColorLeadingActive = .purple
        
        chip1.iconTintTrailingActive = .systemPink
        chip1.iconBGColorTrailingActive = .purple
        
        // MARK: - Corner & Border
        chip1.cornerRadius = 16
        chip1.borderWidth = 1
        
        // MARK: - Shadow
        chip1.shadowOpacity = 0.1
        chip1.shadowRadius = 4
        chip1.shadowOffset = CGSize(width: 0, height: 2)
        chip1.shadowColor = .black
        
        chip1.shadowOpacityActive = 0.3
        chip1.shadowRadiusActive = 6
        chip1.shadowOffsetActive = CGSize(width: 0, height: 4)
        chip1.shadowColorActive = .black
        
        // MARK: - Padding
        chip1.paddingTop = 6
        chip1.paddingBottom = 6
        chip1.paddingLeading = 12
        chip1.paddingTrailing = 12
        
        // MARK: - State
//        chip1.isChipActive = false // toggle true/false to test animation
        
        // MARK: - Delegate
        chip1.delegate = self
    }
    
    
    func didSelectChip(_ chip: KlikIDM_DSChip) {
        chip1.isChipActive.toggle()
        print("Chip tapped")
    }
    
    func didSelectChipIconLeading(_ chip: KlikIDM_DSChip) {
        print("Leading icon tapped")
    }
    
    func didSelectChipIconTrailing(_ chip: KlikIDM_DSChip) {
        print("Trailing icon tapped")
    }
}
