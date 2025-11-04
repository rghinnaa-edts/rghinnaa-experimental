//
//  ScrollingScaleViewController.swift
//  Poinku-DS-SB
//
//  Created by Rizka Ghinna Auliya on 18/02/25.
//

import UIKit
import Poinku_DS

class ScrollingScaleViewController: UIViewController {
    private var collectionView: UICollectionView!
    private var lastContentOffset: CGFloat = 0
    private var visibleCellsBeforeScroll: [IndexPath: CGPoint] = [:]
    private var coachmark: Coachmark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showMultiStepCoachmark()
        }
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
    
    private func showMultiStepCoachmark() {
        guard collectionView.numberOfItems(inSection: 0) >= 3 else { return }
        
        let firstItemIndexPath = IndexPath(item: 0, section: 0)
        let secondItemIndexPath = IndexPath(item: 1, section: 0)
        let thirdItemIndexPath = IndexPath(item: 2, section: 0)
        
        guard let firstCell = collectionView.cellForItem(at: firstItemIndexPath),
              let secondCell = collectionView.cellForItem(at: secondItemIndexPath),
              let thirdCell = collectionView.cellForItem(at: thirdItemIndexPath) else {
            return
        }
        
        let steps = [
            Coachmark.StepConfiguration(
                title: "First Item",
                description: "This is your first stamp card item.",
                targetView: firstCell,
                spotlightRadius: 8,
                tintColor: UIColor.systemGreen
            ),
            Coachmark.StepConfiguration(
                title: "Second Item",
                description: "This is the second item in your collection. You can interact with it to see more details.",
                targetView: secondCell,
                spotlightRadius: 8,
                tintColor: UIColor.systemBlue
            ),
            Coachmark.StepConfiguration(
                title: "Third Item",
                description: "Here's the third item. You can scroll to see more items below.",
                targetView: thirdCell,
                spotlightRadius: 8,
                tintColor: UIColor.systemOrange
            )
        ]
        
        coachmark = Coachmark()
        coachmark?.configureSteps(steps: steps)
        
        coachmark?.onDismiss = { [weak self] in
            self?.coachmark = nil
        }
        
        coachmark?.show(animated: true)
    }
    
}

extension ScrollingScaleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StampCardCell", for: indexPath) as! StampCardCell
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        animateScale(collectionView, scrollView)
        
        if let coachmark = coachmark, coachmark.alpha > 0 {
            coachmark.dismiss(animated: true)
        }
    }
}

extension ScrollingScaleViewController: StaggeredLayoutDelegate {
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
