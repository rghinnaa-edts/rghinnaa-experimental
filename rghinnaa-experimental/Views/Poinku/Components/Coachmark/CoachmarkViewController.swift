//
//  RibbonViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 21/02/25.
//

import UIKit
import Poinku_DS

class CoachmarkViewController: UIViewController {
    
    @IBOutlet var testCard: UIView!
    @IBOutlet var testCard2: UIView!
    @IBOutlet var testCard3: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.showCoachmark()
        }
    }
        
    func showCoachmark() {
        let coachmark = Coachmark(frame: .zero)

        coachmark.configureSteps(steps: [
            Coachmark.StepConfiguration(
                title: "Step 1",
                description: "This is the first step with single spotlight",
                targetView: testCard3
            ),
            
            Coachmark.StepConfiguration(
                title: "Step 2 - Dual Spotlight",
                description: "This step shows both start and end targets with dual spotlights",
                targetView: testCard,
                endTargetView: testCard2,
                spotlightRadius: 8,
                tintColor: UIColor.green
            ),
            
            Coachmark.StepConfiguration(
                title: "Step 3",
                description: "This is the final step with single spotlight",
                targetView: testCard3
            )
        ])

        coachmark.show()
    }
    
    @objc func dismissCoachmark() {
        view.subviews.forEach { subview in
            if let coachmark = subview as? Coachmark {
                coachmark.dismiss()
            }
        }
    }
}
