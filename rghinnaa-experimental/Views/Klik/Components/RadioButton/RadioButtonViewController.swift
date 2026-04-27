//
//  RadioButtonViewController.swift
//  rghinnaa-experimental
//
//  Created by Yovita Handayiani on 04/03/26.
//

import UIKit
import KlikIDM_DS

class RadioButtonViewController: UIViewController{
    
    @IBOutlet weak var radioGroup: RadioGroup!
    @IBOutlet weak var radioBtn: RadioButton!
    
    var display: [[String]] = [["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"], ["Title radio button", "Body text goes here"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        radioGroup.data = display
        radioGroup.displayMode = .vertical
        radioGroup.selectedIndex = 0
        radioGroup.paddingLeading = 8
    }
}
