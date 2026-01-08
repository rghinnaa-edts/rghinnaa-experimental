//
//  CardViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 12/11/25.
//

import UIKit

class Card2ViewController: UIViewController {
    
    @IBOutlet weak var cardView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardView.name = "Rizka Ghinna Auliya"
        cardView.position = "UX Engineer"
        
    }
}
