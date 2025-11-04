//
//  ProfileViewController.swift
//  Poinku-DS
//
//  Created by Rizka Ghinna Auliya on 30/04/25.
//

import UIKit
import Poinku_DS

class ProfileViewController: UIViewController {
    
    @IBOutlet var vMember: UIView!
    @IBOutlet var vMGM: UIView!
    @IBOutlet var vGoogleWallet: UIView!
    
    @IBOutlet var lblMemberName: UILabel!
    @IBOutlet var lblSeeDetail: UILabel!
    @IBOutlet var ivMember: UIImageView!
    @IBOutlet var lblMemberType: UILabel!
    @IBOutlet var ivPhone: UIImageView!
    @IBOutlet var lblPhone: UILabel!
    @IBOutlet var lblAccumulationTitle: UILabel!
    @IBOutlet var lblAccumulation: UILabel!
    @IBOutlet var progressAccumulation: UIProgressView!
    @IBOutlet var lblTransactionTitle: UILabel!
    @IBOutlet var lblTransaction: UILabel!
    @IBOutlet var progressTransaction: UIProgressView!
    @IBOutlet var scrollVoew: UIScrollView!
    
    @IBOutlet var ivMGM: UIImageView!
    @IBOutlet var ivArrowRight: UIImageView!
    @IBOutlet var lblMGM: UILabel!
    @IBOutlet var lblMGMDesc: UILabel!
    @IBOutlet var ivGoogleWallet: UIImageView!
    @IBOutlet var lblGoogleWallet: UILabel!
    
    @IBOutlet var collectionProfile: UICollectionView!
    
    private var profileSettings: [ProfileSettingModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        MGMCardAnimation()
        DispatchQueue.main.async {
            self.showCoachmark()
        }
    }
    
    func setupUI() {
        setupCollectionProfileSetting()
        setupProfileSetting()
        
        vMember.backgroundColor = UIColor.yellow30
        vMember.layer.cornerRadius = 8
        
        vGoogleWallet.backgroundColor = UIColor.black
        vGoogleWallet.layer.cornerRadius = 20
        
        lblMemberName.font = Font.B2.Medium.font
        lblMemberName.textColor = UIColor.white
        lblMemberName.text = "Edward Newgate"
        
        lblSeeDetail.font = Font.B4.Small.font
        lblSeeDetail.textColor = UIColor.white
        lblSeeDetail.text = "Lihat Detail"
        
        ivMember.image = UIImage(named: "placeholder")?.withRenderingMode(.alwaysTemplate)
        ivMember.tintColor = UIColor.white
        
        lblMemberType.font = Font.B4.Small.font
        lblMemberType.textColor = UIColor.white
        lblMemberType.text = "Gold Member"
        
        ivPhone.image = UIImage(named: "placeholder")?.withRenderingMode(.alwaysTemplate)
        ivPhone.tintColor = UIColor.white
        
        lblPhone.font = Font.B4.Small.font
        lblPhone.textColor = UIColor.white
        lblPhone.text = "0812 3456 7890"
        
        lblAccumulationTitle.font = Font.B4.Small.font
        lblAccumulationTitle.textColor = UIColor.white
        lblAccumulationTitle.text = "Akumulasi Transaksi"
        
        lblAccumulation.font = Font.B4.Small.font
        lblAccumulation.textColor = UIColor.white
        lblAccumulation.text = "850.000/2.700.000"
        
        lblTransactionTitle.font = Font.B4.Small.font
        lblTransactionTitle.textColor = UIColor.white
        lblTransactionTitle.text = "Jumlah Transaksi"
        
        lblTransaction.font = Font.B4.Small.font
        lblTransaction.textColor = UIColor.white
        lblTransaction.text = "9/15"
        
        ivMGM.image = UIImage(named: "mgm")
        ivArrowRight.image = UIImage(named: "ic-arrow-right")?.withRenderingMode(.alwaysTemplate)
        ivArrowRight.tintColor = UIColor.blue30
        
        lblMGM.font = Font.H2.font
        lblMGM.textColor = UIColor.blue30
        lblMGM.text = "Ajak Teman, Dapat Untung Bareng!"
        
        lblMGMDesc.font = Font.B4.Small.font
        lblMGMDesc.textColor = UIColor.grey60
        lblMGMDesc.text = "Bagikan kode referral kamu untuk mendapatkan hadiah."
        
        vMGM.layer.borderWidth = 1
        vMGM.layer.borderColor = UIColor.blue30?.cgColor
        vMGM.backgroundColor = UIColor.white
        vMGM.layer.cornerRadius = 8
        
        DispatchQueue.main.async {
            self.ivMGM.image = UIImage(named: "mgm")
            self.ivArrowRight.image = UIImage(named: "ic-arrow-right")?.withRenderingMode(.alwaysTemplate)
            self.ivArrowRight.tintColor = UIColor.blue30
            
            self.lblMGM.font = Font.H2.font
            self.lblMGM.textColor = UIColor.blue30
            self.lblMGM.text = "Ajak Teman, Dapat Untung Bareng!"
            
            self.lblMGMDesc.font = Font.B4.Small.font
            self.lblMGMDesc.textColor = UIColor.grey60
            self.lblMGMDesc.text = "Bagikan kode referral kamu untuk mendapatkan hadiah."
            
            self.vMGM.layer.borderWidth = 1
            self.vMGM.layer.borderColor = UIColor.blue30?.cgColor
            self.vMGM.backgroundColor = UIColor.white
            self.vMGM.layer.cornerRadius = 8
        }
        
        scrollVoew.clipsToBounds = false
        
        ivGoogleWallet.image = UIImage(named: "googlewallet")
        lblGoogleWallet.text = "Tambahkan ke Google Wallet"
        lblGoogleWallet.textColor = UIColor.white
    }
    
    func setupCollectionProfileSetting() {
        let profileFlowLayout = UICollectionViewFlowLayout()
        profileFlowLayout.scrollDirection = .vertical
        profileFlowLayout.minimumInteritemSpacing = 12
        profileFlowLayout.minimumLineSpacing = 12
        profileFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth - profileFlowLayout.sectionInset.left - profileFlowLayout.sectionInset.right
        profileFlowLayout.itemSize = CGSize(width: itemWidth, height: 50)
        
        collectionProfile.collectionViewLayout = profileFlowLayout
        collectionProfile.backgroundColor = .clear
        collectionProfile.showsVerticalScrollIndicator = false
        collectionProfile.decelerationRate = .normal
        collectionProfile.register(ProfileSetting.self, forCellWithReuseIdentifier: "ProfileSetting")
        
        collectionProfile.delegate = self
        collectionProfile.dataSource = self
    }
    
    func setupProfileSetting() {
        profileSettings = [
            ProfileSettingModel(icon: "placeholder", title: "Atur Profil"),
            ProfileSettingModel(icon: "placeholder", title: "Ubah Kode Pin"),
            ProfileSettingModel(icon: "placeholder", title: "Tukarkan Kode"),
            ProfileSettingModel(icon: "placeholder", title: "FAQ"),
            ProfileSettingModel(icon: "placeholder", title: "Hubungi Kami"),
            ProfileSettingModel(icon: "placeholder", title: "Kebijakan Privasi"),
            ProfileSettingModel(icon: "placeholder", title: "Syarat & Ketentuan"),
            ProfileSettingModel(icon: "placeholder", title: "Pengaturan Wallet"),
            ProfileSettingModel(icon: "placeholder", title: "Berikan Rating"),
            ProfileSettingModel(icon: "placeholder", title: "Keluar")
        ]
        
        collectionProfile.reloadData()
    }
    
    func showCoachmark() {
        let coachmark = Coachmark(frame: .zero)

        coachmark.configureSteps(steps: [
            Coachmark.StepConfiguration(
                title: "Program Referral",
                description: "Bagikan kode referral untuk mendapatkan hadiah setiap kali ada teman yang bergabung.",
                targetView: vMGM
            )
        ])
        
        coachmark.onDismiss = {
            DispatchQueue.main.asyncAfter(deadline: .now() + 15.0) {
                self.vMGM.stopAnimationGradientBorder()
                self.vMGM.stopAnimationNeonPulse()
            }
        }

        coachmark.show()
    }
    
    func MGMCardAnimation() {
        DispatchQueue.main.async {
            self.vMGM.startAnimationGradientBorder(
                width: 2,
                colors: [UIColor.white ?? .systemYellow, UIColor.blue30 ?? .systemBlue],
                duration: 3.0
            )

            self.vMGM.startAnimationNeonPulse()
        }
    }

}

extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return profileSettings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileSetting", for: indexPath) as! ProfileSetting
        
        let profileSetting = profileSettings[indexPath.row]
        cell.loadProfileSetting(icon: profileSetting.icon, title: profileSetting.title)
        
        return cell
    }
}
