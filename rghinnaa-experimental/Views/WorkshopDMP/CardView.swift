//
//  CardView.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 12/11/25.
//

import UIKit

@IBDesignable class CardView: UIView {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPosition: UILabel!
    
    @IBInspectable var name: String? {
        didSet { lblName.text = name }
    }
    
    @IBInspectable var position: String? {
        didSet { lblPosition.text = position }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupNib()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupNib()
    }
    
    private func setupNib() {
        let bundle = Bundle(for: type(of: self))
        guard let nib = bundle.loadNibNamed("CardView", owner: self, options: nil),
              let view = nib.first as? UIView else { return }
        
        containerView = view
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(containerView)
        
        setupUI()
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 12
        containerView.backgroundColor = .systemGray
    }
    
}
