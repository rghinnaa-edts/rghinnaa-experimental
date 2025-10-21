//
//  PoinCardViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 21/02/25.
//

import UIKit

class PoinCardViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var lastContentOffset: CGFloat = 0
    private var visibleCellsBeforeScroll: [IndexPath: CGPoint] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = StaggeredLayout()
        layout.delegate = self
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16 , left: 16, bottom: 16, right: 8)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PoinCardCell.self, forCellWithReuseIdentifier: "PoinCardCell")
        
        view.addSubview(collectionView)
    }
}

extension PoinCardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PoinCardCell", for: indexPath) as! PoinCardCell
        
        return cell
    }
}

extension PoinCardViewController: StaggeredLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, width: CGFloat) -> CGFloat {
        let cell = PoinCardCell()
        
        configureCell(cell, for: indexPath)
        
        let height = cell.calculateHeight(for: width)
        
        return height
    }
    
    private func configureCell(_ cell: PoinCardCell, for indexPath: IndexPath) {
        // Configure with data that would affect height
        // For example:
        // cell.lblPoinCard.text = "Some text that might vary in length..."
        // cell.btnExchange.isHidden = (indexPath.item % 2 == 0)
        
        // This will depend on your specific data model
    }
}
