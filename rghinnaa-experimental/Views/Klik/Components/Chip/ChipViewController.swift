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
        print("Chip selected:", chip)
    }
    
    func didSelectChipIconLeading(_ chip: KlikIDM_DS.KlikIDM_DSChip) {
        print("Chip Leading:", chip)
    }
    
    func didSelectChipIconTrailing(_ chip: KlikIDM_DS.KlikIDM_DSChip) {
        print("Chip Trailing:", chip)
    }
}
