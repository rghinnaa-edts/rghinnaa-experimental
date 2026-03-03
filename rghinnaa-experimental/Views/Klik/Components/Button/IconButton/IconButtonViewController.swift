//
//  ButtonViewController.swift
//  rghinnaa-experimental
//
//  Created by Yovita Handayiani on 11/01/26.
//

import UIKit
import KlikIDM_DS

class IconButtonViewController: UIViewController{
    @IBOutlet weak var iconButton: IconButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTestButton()
    }
    
    private func setupTestButton() {
        iconButton.btnType = "secondary"
        iconButton.btnSize = "small"
        iconButton.btnState = "rest"
        iconButton.bgColorStart = .systemPurple
        iconButton.bgColorEnd = .systemPink
        iconButton.bgColorOrientation = "vertical"
        iconButton.cornerRadius = 4
        iconButton.borderWidth = 2
        iconButton.borderColor = .white
        iconButton.icon = UIImage(named: "ic-cart")
        iconButton.iconTint = .yellow
        iconButton.iconSize = 24
        iconButton.paddingTop = 8
        iconButton.paddingBottom = 8
        iconButton.paddingLeading = 8
        iconButton.paddingTrailing = 8
        iconButton.shadowColor = .black
        iconButton.shadowOpacity = 0.3
        iconButton.shadowRadius = 6
        iconButton.shadowOffset = CGSize(width: 0, height: 3)
        iconButton.configureBadge{ badge in
            badge.label = "1"
        }
    }
}
