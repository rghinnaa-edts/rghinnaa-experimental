//
//  OnBoardinggViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 25/04/25.
//

import UIKit
import Poinku_DS

class OnBoardingViewController: UIViewController {
    
    @IBOutlet var onBoarding: OnBoarding!
    
    @IBOutlet var btnRegister: UIButton!
    @IBOutlet var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupSlides()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    private func setupSlides() {
        onBoarding.slides = [
//            OnBoarding2Slide(
//                imageIllustration: UIImage(named: "illustration-onboard1"),
//                imageBackground: UIImage(named: "bg-onboard1"),
//                title: "Kumpulin Poin, Dapat Hadiah!",
//                description: "Kumpulin Poin & Stamp dari setiap transaksi, tukarkan dengan hadiah yang cuma ada di sini!"),
//            OnBoarding2Slide(
//                imageIllustration: UIImage(named: "illustration-onboard2"),
//                imageBackground: UIImage(named: "bg-onboard2"),
//                title: "Member Lebih Untung!",
//                description: "Nikmati berbagai Promo Khusus Member, Diskon, Bonus, sampai Belanja Gratis, dijamin untung banget!"),
//            OnBoarding2Slide(
//                imageIllustration: UIImage(named: "illustration-onboard3"),
//                imageBackground: UIImage(named: "bg-onboard3"),
//                title: "Semua Ada di Poinku",
//                description: "Cek katalog promo terbaru, info event seru, sampai cek struk belanja, semua dalam satu aplikasi!")
            OnBoardingSlide(
                image: UIImage(named: "onboard1"),
                title: "Kumpulin Poin, Dapat Hadiah!",
                description: "Kumpulin Poin & Stamp dari setiap transaksi, tukarkan dengan hadiah yang cuma ada di sini!"),
            OnBoardingSlide(
                image: UIImage(named: "onboard2"),
                title: "Member Lebih Untung!",
                description: "Nikmati berbagai Promo Khusus Member, Diskon, Bonus, sampai Belanja Gratis, dijamin untung banget!"),
            OnBoardingSlide(
                image: UIImage(named: "onboard3"),
                title: "Semua Ada di Poinku",
                description: "Cek katalog promo terbaru, info event seru, sampai cek struk belanja, semua dalam satu aplikasi!")
        ]
    }
    
    private func setupUI() {
        let attrRegister = NSAttributedString(string: "Daftar Sekarang", attributes: [
            .font: Font.Button.Big.font,
            .foregroundColor: UIColor.white ?? .systemYellow
        ])
        btnRegister.setAttributedTitle(attrRegister, for: .normal)
        btnRegister.backgroundColor = UIColor.blue30
        btnRegister.tintColor = UIColor.blue30
        btnRegister.layer.cornerRadius = 8
        
        let attrLogin = NSAttributedString(string: "Masuk", attributes: [
            .font: Font.Button.Big.font,
            .foregroundColor: UIColor.blue30 ?? .systemBlue
        ])
        btnLogin.setAttributedTitle(attrLogin, for: .normal)
        btnLogin.layer.borderColor = UIColor.blue30?.cgColor
        btnLogin.layer.borderWidth = 1
        btnLogin.layer.cornerRadius = 8
        btnLogin.clipsToBounds = true
    }
    
    @IBAction func goToRegister(_ sender: Any) {
//        let vc = UIStoryboard(name: "RegisterViewController", bundle: nil).instantiateViewController(withIdentifier: "RegisterPage")
//        navigationController?.pushViewController(vc, animated: true)
        
//        onBoarding.viewWillDisappear()
    }
    
    @IBAction func goToLogin(_ sender: Any) {
//        let vc = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateViewController(withIdentifier: "LoginPage")
//        navigationController?.pushViewController(vc, animated: true)
        
//        onBoarding.viewWillDisappear()
    }
}
