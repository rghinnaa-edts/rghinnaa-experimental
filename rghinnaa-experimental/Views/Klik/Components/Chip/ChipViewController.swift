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
        chip1.delegate = self
    }
    
    func didSelectChip(_ chip: KlikIDM_DS.KlikIDM_DSChip) {
        chip.isChipActive.toggle()
//        
//        if (chip.isChipActive) {
//            chip.bgColorActive = .blue50
//            chip.labelColorActive = .white
//            chip.iconTintLeadingActive = .blue50
//            chip.iconBGColorLeadingActive = .white
//            chip.iconBGColorLeadingActive = UIColor.white
//            chip.iconBGColorTrailingActive = UIColor.white
//        }
        print("Chip selected. New state:", chip.isChipActive ? "active" : "inactive")
    }
    
    func didSelectChipIconLeading(_ chip: KlikIDM_DS.KlikIDM_DSChip) {
        print("Chip Leading:", chip)
    }
    
    func didSelectChipIconTrailing(_ chip: KlikIDM_DS.KlikIDM_DSChip) {
        print("Chip Trailing:", chip)
    }
}
