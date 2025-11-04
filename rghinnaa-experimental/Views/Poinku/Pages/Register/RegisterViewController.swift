//
//  RegisterViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 21/04/25.
//

import UIKit
import Poinku_DS

class RegisterViewController: UIViewController {
    
    @IBOutlet var btnBack: UIButton!
    @IBOutlet var vToolbar: UIView!
    @IBOutlet var lblToolbar: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblDesc: UILabel!
    @IBOutlet var lblTnC: UILabel!
    @IBOutlet var nameField: Textfield!
    @IBOutlet var phoneNumberField: Textfield!
    @IBOutlet var referralField: Textfield!
    @IBOutlet var vBtnLogin: UIView!
    @IBOutlet var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        self.navigationController?.setToolbarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        setupTexfield()
        
        btnBack.setTitle("", for: .normal)
        
        vToolbar.layer.shadowOpacity = 0.15
        vToolbar.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        vToolbar.layer.shadowRadius = 2.0
        
        lblToolbar.text = "Daftar"
        lblTitle.text = "Halo"
        lblDesc.text = "Silakan masukkan nama lengkap dan nomor handphone untuk registrasi Indomaret Poinku."
        lblTnC.text = "Dengan menggunakan aplikasi Indomaret Poinku, saya menyetujui syarat dan ketentuan"
        
        lblToolbar.font = Font.H1.font
        lblToolbar.textColor = UIColor.grey80
        
//        lblTitle.font = Font.Display.D1.font
        lblTitle.textColor = UIColor.grey80
        
//        lblDesc.font = Font.Paragraph.P1.Small.font
        lblDesc.textColor = UIColor.grey80
        
//        lblTnC.font = Font.Paragraph.P2.Small.font
        lblTnC.textColor = UIColor.grey80
        
        vBtnLogin.layer.shadowOpacity = 0.15
        vBtnLogin.layer.shadowOffset = CGSize(width: 0.0, height: -3.0)
        vBtnLogin.layer.shadowRadius = 2.0
        
        btnLogin.isEnabled = false
        
        setupButton(isEnabled: false)
    }
    
    private func setupTexfield() {
        nameField.label = "Nama Lengkap Sesuai KTP"
        nameField.placeholder = "Masukkan Nama Lengkap Sesuai KTP"
        nameField.keyboardType = .default
        nameField.returnKeyType = .next
        nameField.delegate = self
        
        phoneNumberField.label = "Nomor Handphone"
        phoneNumberField.placeholder = "Masukkan Nomor Handphone"
        phoneNumberField.keyboardType = .phonePad
        phoneNumberField.returnKeyType = .next
        phoneNumberField.delegate = self
        
        referralField.label = "Kode Referral (Optional)"
        referralField.placeholder = "Masukkan Kode Referral"
        referralField.keyboardType = .default
        referralField.returnKeyType = .done
        referralField.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                                  selector: #selector(textFieldDidChange(_:)),
                                                  name: UITextField.textDidChangeNotification,
                                                  object: nameField.getTextField())
        
        NotificationCenter.default.addObserver(self,
                                                  selector: #selector(textFieldDidChange(_:)),
                                                  name: UITextField.textDidChangeNotification,
                                                  object: phoneNumberField.getTextField())
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
            .foregroundColor: UIColor.white ?? .systemYellow
        ])
        btnLogin.setAttributedTitle(attrLogin, for: .normal)
        
        btnLogin.contentEdgeInsets = UIEdgeInsets(top: 6, left: 8, bottom: 6, right: 8)
        btnLogin.layer.cornerRadius = 8
    }
    
    @objc private func textFieldDidChange(_ notification: Notification) {
        let isNameFieldFilled = !(nameField.text?.isEmpty ?? true)
        let isPhoneFieldFilled = !(phoneNumberField.text?.isEmpty ?? true)
        
        setupButton(isEnabled: isNameFieldFilled && isPhoneFieldFilled)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func btnBack(_ sender: Any) {
        if self.navigationController != nil {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        let vc = UIStoryboard(name: "VerificationViewController", bundle: nil).instantiateViewController(withIdentifier: "VerificationPage")
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        if textField == nameField.getTextField() {
//            passwordTextField.becomeFirstResponder()
//        } else if textField == passwordTextField.getTextField() {
//            passwordTextField.resignFirstResponder()
//            loginButtonTapped(UIButton())
//        }
        return true
    }
}
