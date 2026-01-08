//
//  Badge.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 22/12/25.
//

import UIKit
import KlikIDM_DS

class BadgeViewController: UIViewController {
    
    @IBOutlet weak var badgeTest: Badge!
    
    override func viewDidLoad() {
        setupUI()
    }
    
    private func setupUI() {
        badgeTest.title = "1/10000000"
        badgeTest.titleColor = UIColor.white
        badgeTest.bgColor = UIColor.systemPink
        badgeTest.cornerRadius = 4
        badgeTest.borderWidth = 1
        badgeTest.borderColor = UIColor.red
    }
    
}
