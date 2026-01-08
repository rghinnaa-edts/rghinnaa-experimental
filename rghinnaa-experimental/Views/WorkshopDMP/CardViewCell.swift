//
//  CardViewCell.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 12/11/25.
//

import UIKit

class CardViewCell: UICollectionViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var cardView: CardView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        
        cardView.name = "Rizka Ghinna Auliya"
        cardView.position = "UX Engineer"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
