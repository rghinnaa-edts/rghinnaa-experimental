//
//  ChipCollectionViewCell.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 21/03/25.
//

import UIKit

class ChipCollectionViewCell: UICollectionViewCell {
    
    private var chipView: Chip!
    
    var onChipTap: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupChipView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupChipView()
    }
    
    private func setupChipView() {
        chipView = Chip(frame: contentView.bounds)
        chipView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.addSubview(chipView)
        
        chipView.onTap = { [weak self] in
            self?.onChipTap?()
        }
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let attributes = super.preferredLayoutAttributesFitting(layoutAttributes)
        let size = chipView.systemLayoutSizeFitting(
            CGSize(width: 50, height: 24),
            withHorizontalFittingPriority: .defaultLow,
            verticalFittingPriority: .required
        )
        attributes.size = size
        return attributes
    }
    
    var isClickable: Bool {
        get { return chipView.isClickable }
        set { chipView.isClickable = newValue }
    }
    
    var text: String {
        get { return chipView.text }
        set { chipView.text = newValue }
    }
    
    var isActive: Bool {
        get { return chipView.isActive }
        set { chipView.isActive = newValue }
    }
    
    var activeColor: UIColor {
        get { return chipView.activeColor }
        set { chipView.activeColor = newValue }
    }
    
    var inactiveColor: UIColor {
        get { return chipView.inactiveColor }
        set { chipView.inactiveColor = newValue }
    }
    
    var borderActiveColor: CGColor {
        get { return chipView.borderActiveColor }
        set { chipView.borderActiveColor = newValue }
    }
    
    var borderInactiveColor: CGColor? {
        get { return chipView.borderInactiveColor }
        set { chipView.borderInactiveColor = newValue }
    }
    
    func calculateHeight(for width: CGFloat) -> CGFloat {
        chipView.layoutIfNeeded()
        
        let widthConstraint = chipView.widthAnchor.constraint(equalToConstant: width)
        widthConstraint.isActive = true
        
        let size = chipView.systemLayoutSizeFitting(
            CGSize(width: width, height: UIView.layoutFittingCompressedSize.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )
        
        widthConstraint.isActive = false
        
        return size.height
    }

    func calculateWidth() -> CGFloat {
        chipView.layoutIfNeeded()
        return chipView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).width
    }
    
}
