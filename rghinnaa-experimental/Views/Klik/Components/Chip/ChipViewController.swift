//
//  ChipViewController.swift
//  rghinnaa-experimental
//
//  Created by Yovita Handayiani on 11/01/26.
//

import UIKit
import KlikIDM_DS

class ChipViewController: UIViewController, ChipDelegate {
    @IBOutlet weak var chip: KlikIDM_DSChip!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chip.iconLeading = UIImage(named: "placeholder")
        chip.iconTrailing = UIImage(named: "placeholder")
        chip.iconSize = 20
        chip.iconSpacing = 8
        chip.labelColor = .systemBlue
        chip.bgColor = .systemGray6
        chip.borderColor = .systemBlue
        chip.iconTintLeading = .white
        chip.iconBGColorLeading = .systemOrange
        chip.iconTintTrailing = .white
        chip.iconBGColorTrailing = .systemRed
        
        chip.labelColorActive = .white
        chip.bgColorActive = .systemBlue
        chip.borderColorActive = .white
        chip.iconTintLeadingActive = .systemRed
        chip.iconBGColorLeadingActive = .white
        chip.iconTintTrailingActive = .systemOrange
        chip.iconBGColorTrailingActive = .white
        
        chip.borderWidth = 1
        chip.shadowOpacity = 0.1
        chip.shadowRadius = 4
        chip.shadowOffset = CGSize(width: 0, height: 2)
        chip.shadowColor = .black
        chip.shadowOpacityActive = 0.3
        chip.shadowRadiusActive = 6
        chip.shadowOffsetActive = CGSize(width: 0, height: 4)
        chip.shadowColorActive = .black
        chip.paddingTop = 6
        chip.paddingBottom = 6
        chip.paddingLeading = 12
        chip.paddingTrailing = 12
        chip.delegate = self
    }
    
    
    func didSelectChip(_ chip: KlikIDM_DSChip) {
        chip.isChipActive.toggle()
        print("Chip tapped")
    }
    
    func didSelectChipIconLeading(_ chip: KlikIDM_DSChip) {
        print("Leading icon tapped")
    }
    
    func didSelectChipIconTrailing(_ chip: KlikIDM_DSChip) {
        print("Trailing icon tapped")
    }
}
