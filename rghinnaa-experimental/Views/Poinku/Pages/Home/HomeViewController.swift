//
//  HomeViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 16/06/25.
//

import UIKit
import Poinku_DS

class HomeViewController: UIViewController {
    
    @IBOutlet var vStep1: UIView!
    @IBOutlet var vStep2: UIView!
    @IBOutlet var vStep3: UIView!
    @IBOutlet var vStep4: UIView!
    @IBOutlet var vStep5: UIView!
    @IBOutlet var vStep6: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
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
                title: "Scan QR dan Kumpulkan Reward!",
                description: "Saat belanja, jangan lupa scan QR untuk mendapatkan poin dan stamp.",
                targetView: vStep1
            ),
            Coachmark.StepConfiguration(
                title: "Tukar Poin Loyalty dan Stamp jadi i-Kupon!",
                description: "Kumpulkan Poin Loyalty dan Stamp, lalu tukarkan jadi i-Kupon di sini.",
                targetView: vStep2
            ),
            Coachmark.StepConfiguration(
                title: "Lihat i-Kupon yang Kamu Punya!",
                description: "Poin Loyalty & Stamp yang sudah kamu tukarkan jadi i-Kupon bisa kamu lihat dan gunakan di sini.",
                targetView: vStep3
            ),
            Coachmark.StepConfiguration(
                title: "Cek Riwayat Transaksi dan Struk Lebih Mudah!",
                description: "Kamu juga bisa melihat riwayat transaksi serta struk belanja kamu pada halaman ini.",
                targetView: vStep4
            ),
            Coachmark.StepConfiguration(
                title: "Nikmati Banyak Promo Setiap Hari!",
                description: "Cek seluruh promo yang sedang berjalan di sini.",
                targetView: vStep5
            ),
            Coachmark.StepConfiguration(
                title: "Bergabung Menjadi Member Poinku!",
                description: "Gabung jadi member Poinku dan kumpulkan poin serta stamp untuk ditukar dengan berbagai hadiah menarik.",
                targetView: vStep6
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
