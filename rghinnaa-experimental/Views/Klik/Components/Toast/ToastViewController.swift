//
//  ToastViewController.swift
//  rghinnaa-experimental
//
//  Created by Yovita Handayiani on 27/01/26.
//

import UIKit
import KlikIDM_DS

class ToastViewController: UIViewController {
    
    @IBAction func testButton(_ sender: Any) {
        ToastManager.toast.show(
            rootView: self.view,
            duration: .indefinite,
            animation: .slide,
            swipeDirection: .vertical,
            configure: { toast in
                toast.toastState = "info"
                toast.iconLeading = UIImage(named: "placeholder")
                toast.configureButton{ btn in
                    btn.label = "Button"
                    btn.iconTrailing = UIImage(systemName: "chevron.right")
                }
                toast.configureIconButton{ btn in
                    btn.icon = UIImage(systemName: "chevron.right")
                }
            })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
