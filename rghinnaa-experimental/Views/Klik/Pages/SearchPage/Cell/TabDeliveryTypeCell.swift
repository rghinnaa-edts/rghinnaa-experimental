//
//  TabCell.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 11/12/25.
//

import UIKit
import KlikIDM_DS

class TabDeliveryTypeCell: UICollectionViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var ivTab: UIImageView!
    @IBOutlet weak var lblTab: UILabel!
    @IBOutlet weak var lblTabDesc: UILabel!
    @IBOutlet weak var vDivider: UIView!
    
    public var tabTitleColor: UIColor? {
        didSet {
            updateTitleColor()
        }
    }
    
    public var tabTitleActiveColor: UIColor? {
        didSet {
            updateTitleColor()
        }
    }
    
    public var tabDescColor: UIColor? {
        didSet {
            updateDescColor()
        }
    }
    
    public var tabDescActiveColor: UIColor? {
        didSet {
            updateDescColor()
        }
    }
    
    public var tabIndicatorColor: UIColor? {
        didSet {
            vDivider.backgroundColor = tabIndicatorColor
        }
    }
    
    public var tabBackgroundColor: UIColor? {
        didSet {
            updateBackgroundColor()
        }
    }
    
    public var tabBackgroundActiveColor: UIColor? {
        didSet {
            updateBackgroundColor()
        }
    }
    
    public var isSelectedState: Bool = false {
        didSet { updateAppearance() }
    }
    
    public var currentIndex: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupNib()
    }
    
    private func setupNib() {
        let bundle = Bundle(for: type(of: self))
        if let nib = bundle.loadNibNamed("TabDeliveryTypeCell", owner: self, options: nil),
           let view = nib.first as? UIView {
            
            containerView = view
            containerView.frame = bounds
            containerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(containerView)
        }
    }
    
    func loadData(_ data: TabDeliveryTypeModel) {
        lblTab.text = data.title
        lblTabDesc.text = data.desc
        ivTab.image = data.icon?.withRenderingMode(.alwaysTemplate)
    }
    
    private func updateAppearance() {
        updateTitleColor()
        updateDescColor()
        updateDividerVisibility()
    }
    
    private func updateTitleColor() {
        lblTab.textColor = isSelectedState ? tabTitleActiveColor : tabTitleColor
        ivTab.tintColor = isSelectedState ? tabTitleActiveColor : tabTitleColor
    }
    
    private func updateDescColor() {
        lblTabDesc.textColor = isSelectedState ? tabDescActiveColor : tabDescColor
    }
    
    private func updateBackgroundColor() {
        containerView.backgroundColor = isSelectedState ? tabBackgroundActiveColor : tabBackgroundColor
    }
    
    private func updateDividerVisibility() {
        vDivider.isHidden = !isSelectedState
    }
    
}

struct TabDeliveryTypeModel: TabDefaultModelProtocol {
    var id: String
    var title: String
    var desc: String
    var icon: UIImage?
    
    public init(id: String, title: String, desc: String, icon: UIImage? = nil) {
        self.id = id
        self.title = title
        self.desc = desc
        self.icon = icon
    }
}

extension TabDeliveryTypeCell: TabDefaultCellProtocol {
    public func loadData(item: TabDefaultModelProtocol) {
        if let data = item as? TabDeliveryTypeModel {
            loadData(data)
        } else {
            let data = TabDeliveryTypeModel(
                id: item.id,
                title: item.title,
                desc: "",
                icon: nil
            )
            loadData(data)
        }
    }
}
