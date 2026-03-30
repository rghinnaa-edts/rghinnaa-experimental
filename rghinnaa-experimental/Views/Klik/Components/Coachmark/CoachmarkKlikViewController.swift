//
//  CoachmarkViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 06/03/26.
//

import UIKit
import KlikIDM_DS

class CoachmarkKlikViewController: UIViewController {
    
    @IBOutlet weak var vCard1: UIView!
    @IBOutlet weak var vCard2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async {
            self.showCoachmark()
        }
        
    }
    
    func showCoachmark() {
        let coachmark = CoachmarkKlik(frame: .zero)

        coachmark.stepConjunction = "dari"
        coachmark.btnFirstTint = UIColor.red
        coachmark.btnSecondTint = UIColor.purple
        
        coachmark.configureSteps(steps: [
            CoachmarkStepConfig(
                title: "Step 1",
                description: "The quick brown fox jumps over the lazy dog",
                targetView: vCard1
            ),
            
            CoachmarkStepConfig(
                title: "Step 2",
                description: "This step shows both start and end targets with dual spotlights",
                targetView: vCard2
            )
        ])

        coachmark.show()
    }
}
