//
//  FadeViewController.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 18/02/25.
//

import UIKit

class ScrollingFadeViewController: UIViewController {
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
        collectionView.register(StampCardCell.self, forCellWithReuseIdentifier: "StampCardCell")
        
        view.addSubview(collectionView)
    }
}

extension ScrollingFadeViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StampCardCell", for: indexPath) as! StampCardCell
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        animateFade(collectionView, scrollView)
    }
}

extension ScrollingFadeViewController: StaggeredLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, width: CGFloat) -> CGFloat {
        let cell = StampCardCell()
        
        configureCell(cell, for: indexPath)
        
        let height = cell.calculateHeight(for: width)
        
        return height
    }
    
    private func configureCell(_ cell: StampCardCell, for indexPath: IndexPath) {
        // Configure with data that would affect height
        // For example:
        // cell.lblPoinCard.text = "Some text that might vary in length..."
        // cell.btnExchange.isHidden = (indexPath.item % 2 == 0)
        
        // This will depend on your specific data model
    }
}
