//
//  Regsiter1ViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 11/06/25.
//

import UIKit
import Poinku_DS

class Register1ViewController: UIViewController {
    
    @IBOutlet var vStep: StepPageNav!
    @IBOutlet var fieldName: Textfield!
    @IBOutlet var fieldPhone: Textfield!
    @IBOutlet var fieldBirthday: Textfield!
    @IBOutlet var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupStep() {
        vStep.title = ["Isi Data Diri", "Verifikasi", "Buat PIN"]
        vStep.currentStep = 1
    }
    
    private func setupUI() {
        vStep.title = ["Isi Data Diri", "Verifikasi", "Buat PIN"]
        vStep.currentStep = 1
        
        setupTextField()
        setupButton(isEnabled: true)
    }
    
    private func setupTextField() {
        fieldName.label = "Nama Lengkap Sesuai KTP"
        fieldName.placeholder = "Masukkan Nama Lengkap Sesuai KTP"
        fieldName.keyboardType = .default
        fieldName.returnKeyType = .next
        
        fieldPhone.label = "Nomor Handphone"
        fieldPhone.placeholder = "Masukkan Nomor Handphone"
        fieldPhone.keyboardType = .numberPad
        fieldPhone.returnKeyType = .next
        
        fieldBirthday.label = "Tanggal Lahir (Opsional)"
        fieldBirthday.placeholder = "Masukkan Tanggal Lahir"
        fieldBirthday.keyboardType = .numberPad
        fieldBirthday.returnKeyType = .next
    }
    
    private func setupButton(isEnabled: Bool) {
        btnLogin.isEnabled = isEnabled
        
        if isEnabled {
            btnLogin.backgroundColor = UIColor.blue30
            btnLogin.tintColor = UIColor.blue30
        } else {
            btnLogin.backgroundColor = UIColor.grey30
            btnLogin.tintColor = UIColor.grey30
        }
        
        let attrLogin = NSAttributedString(string: "Masuk", attributes: [
            .font: Font.Button.Big.font,
            .foregroundColor: UIColor.white
        ])
        btnLogin.setAttributedTitle(attrLogin, for: .normal)
        
        btnLogin.contentEdgeInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        btnLogin.layer.cornerRadius = 8
    }
    
    @IBAction func GoToRegister2(_ sender: Any) {
        let vc = UIStoryboard(name: "Register2ViewController", bundle: nil).instantiateViewController(withIdentifier: "Register2Page")
        navigationController?.pushViewController(vc, animated: true)
    }
}
