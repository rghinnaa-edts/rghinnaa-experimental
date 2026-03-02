////
////  ToastViewController.swift
////  rghinnaa-experimental
////
////  Created by Yovita Handayiani on 27/01/26.
////
//
//import UIKit
//import KlikIDM_DS
//
//class ToastViewController: UIViewController {
//    
//    @IBAction func testButton(_ sender: Any) {
//        ToastManager.instance.show(
//            rootView: self.view,
//            duration: .indefinite,
//            offsetY: .top(0.0),
//            animation: .slide,
//            swipeDirection: .vertical,
//            configure: {
//                $0.label = "Something went wrong"
//                $0.iconLeading = UIImage(systemName: "xmark.circle.fill")
//    //            $0.toastState = "info"
//                $0.toastState = "danger"
//                $0.bgColor = .systemTeal
//                 $0.configureButton{ btn in
//                     btn.label = ""
//                     btn.iconSpacing = 0
//                     btn.iconTrailing = UIImage(systemName: "chevron.right")
//                     btn.bgColor = .systemBlue
//                 }
//                 $0.configureIconButton{ btn in
////                     btn.icon = UIImage(systemName: "chevron.right")
//                     btn.bgColor = .red
//                 }
//        })
//    }
//    
////    override func viewDidLoad() {
////        super.viewDidLoad()
////    }
//    
//    // MARK: - UI
//    private let scrollView = UIScrollView()
//    private let stackView = UIStackView()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupScrollView()
//        setupButtons()
//    }
//    
//    private func setupScrollView() {
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(scrollView)
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
//            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
//        ])
//        
//        stackView.axis = .vertical
//        stackView.spacing = 12
//        stackView.alignment = .fill
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.addSubview(stackView)
//        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
//            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
//            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
//            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
//            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32)
//        ])
//    }
//    
//    private func makeButton(title: String, action: Selector) -> UIButton {
//        let btn = UIButton(type: .system)
//        btn.setTitle(title, for: .normal)
//        btn.backgroundColor = .systemBlue
//        btn.setTitleColor(.white, for: .normal)
//        btn.layer.cornerRadius = 8
//        btn.heightAnchor.constraint(equalToConstant: 44).isActive = true
//        btn.addTarget(self, action: action, for: .touchUpInside)
//        return btn
//    }
//    
//    private func setupButtons() {
//        let buttons: [(String, Selector)] = [
//            // ── KlikIDM_DSButton toasts ──────────────────────────────────────
//            ("1. [DSButton] Info + Fade + Bottom + Short", #selector(test_DSButton_Info_Fade_Bottom_Short)),
//            ("2. [DSButton] Danger + Fade + Bottom + Long", #selector(test_DSButton_Danger_Fade_Bottom_Long)),
//            ("3. [DSButton] Info + Slide + Bottom + Custom(4s)", #selector(test_DSButton_Info_Slide_Bottom_Custom)),
//            ("4. [DSButton] Info + Fade + Top + Short", #selector(test_DSButton_Info_Fade_Top_Short)),
//            ("5. [DSButton] Danger + Slide + Top + Indefinite", #selector(test_DSButton_Danger_Slide_Top_Indefinite)),
//            ("6. [DSButton] Custom BG + Label Color + Font", #selector(test_DSButton_CustomColors)),
//            ("7. [DSButton] Custom Icon + Tint + Size", #selector(test_DSButton_CustomIcon)),
//            ("8. [DSButton] Custom Padding + Spacing + Radius", #selector(test_DSButton_CustomPadding)),
//            ("9. [DSButton] Custom Shadow", #selector(test_DSButton_CustomShadow)),
//            ("10. [DSButton] Custom Border", #selector(test_DSButton_CustomBorder)),
//            ("11. [DSButton] Swipe Horizontal", #selector(test_DSButton_SwipeHorizontal)),
//            ("12. [DSButton] Swipe Vertical Bottom", #selector(test_DSButton_SwipeVerticalBottom)),
//            ("13. [DSButton] Swipe Vertical Top", #selector(test_DSButton_SwipeVerticalTop)),
//            ("14. [DSButton] Attributed Label", #selector(test_DSButton_AttributedLabel)),
//            ("15. [DSButton] HorizontalPadding Wide", #selector(test_DSButton_HorizontalPaddingWide)),
//            ("16. [DSButton] No Icon (hidden)", #selector(test_DSButton_NoIcon)),
//            
//            // ── IconButton toasts ────────────────────────────────────────────
//            ("17. [IconButton] Info + Fade + Bottom + Short", #selector(test_IconButton_Info_Fade_Bottom_Short)),
//            ("18. [IconButton] Danger + Fade + Bottom + Long", #selector(test_IconButton_Danger_Fade_Bottom_Long)),
//            ("19. [IconButton] Info + Slide + Bottom + Custom(4s)", #selector(test_IconButton_Info_Slide_Bottom_Custom)),
//            ("20. [IconButton] Info + Fade + Top + Short", #selector(test_IconButton_Info_Fade_Top_Short)),
//            ("21. [IconButton] Danger + Slide + Top + Indefinite", #selector(test_IconButton_Danger_Slide_Top_Indefinite)),
//            ("22. [IconButton] Custom BG + Label Color + Font", #selector(test_IconButton_CustomColors)),
//            ("23. [IconButton] Custom Icon + Tint + Size (leading)", #selector(test_IconButton_CustomLeadingIcon)),
//            ("24. [IconButton] Custom Padding + Spacing + Radius", #selector(test_IconButton_CustomPadding)),
//            ("25. [IconButton] Custom Shadow", #selector(test_IconButton_CustomShadow)),
//            ("26. [IconButton] Custom Border", #selector(test_IconButton_CustomBorder)),
//            ("27. [IconButton] Swipe Horizontal", #selector(test_IconButton_SwipeHorizontal)),
//            ("28. [IconButton] Swipe Vertical Bottom", #selector(test_IconButton_SwipeVerticalBottom)),
//            ("29. [IconButton] Swipe Vertical Top", #selector(test_IconButton_SwipeVerticalTop)),
//            ("30. [IconButton] Attributed Label", #selector(test_IconButton_AttributedLabel)),
//            ("31. [IconButton] Icon Secondary Type", #selector(test_IconButton_SecondaryType)),
//            ("32. [IconButton] Icon Tertiary Type", #selector(test_IconButton_TertiaryType)),
//            
//            // ── Dismiss ──────────────────────────────────────────────────────
//            ("33. Manual Dismiss (animated)", #selector(test_ManualDismissAnimated)),
//            ("34. Manual Dismiss (not animated)", #selector(test_ManualDismissNotAnimated)),
//        ]
//        
//        buttons.forEach { (title, action) in
//            stackView.addArrangedSubview(makeButton(title: title, action: action))
//        }
//    }
//    
//    // MARK: - Helpers
//    private var rootView: UIView { view }
//    
//    // =========================================================================
//    // MARK: - KlikIDM_DSButton Tests
//    // =========================================================================
//    
//    // 1
//    @objc func test_DSButton_Info_Fade_Bottom_Short() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .short,
//            horizontalPadding: 16,
//            offsetY: .bottom(60),
//            animation: .fade,
//            swipeDirection: .horizontal,
//            onButtonTap: { print("DSButton tapped – test 1") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Info toast with DSButton – fade, bottom, short"
//            toast.configureButton { btn in
//                btn.label = "Undo"
//            }
//        }
//    }
//    
//    // 2
//    @objc func test_DSButton_Danger_Fade_Bottom_Long() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            horizontalPadding: 16,
//            offsetY: .bottom(60),
//            animation: .fade,
//            swipeDirection: .horizontal,
//            onButtonTap: { print("DSButton tapped – test 2") }
//        ) { toast in
//            toast.toastState = "danger"
//            toast.label = "Danger toast with DSButton – fade, bottom, long"
//            toast.configureButton { btn in
//                btn.label = "Retry"
//            }
//        }
//    }
//    
//    // 3
//    @objc func test_DSButton_Info_Slide_Bottom_Custom() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .custom(4),
//            horizontalPadding: 16,
//            offsetY: .bottom(60),
//            animation: .slide,
//            swipeDirection: .horizontal,
//            onButtonTap: { print("DSButton tapped – test 3") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Info toast – slide, bottom, custom 4s"
//            toast.configureButton { btn in
//                btn.label = "OK"
//            }
//        }
//    }
//    
//    // 4
//    @objc func test_DSButton_Info_Fade_Top_Short() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .short,
//            horizontalPadding: 16,
//            offsetY: .top(16),
//            animation: .fade,
//            swipeDirection: .vertical,
//            onButtonTap: { print("DSButton tapped – test 4") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Info toast – fade, top, short"
//            toast.configureButton { btn in
//                btn.label = "Dismiss"
//            }
//        }
//    }
//    
//    // 5
//    @objc func test_DSButton_Danger_Slide_Top_Indefinite() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .indefinite,
//            horizontalPadding: 16,
//            offsetY: .top(16),
//            animation: .slide,
//            swipeDirection: .vertical,
//            onButtonTap: {
//                print("DSButton tapped – test 5 (tap Manual Dismiss to close)")
//            }
//        ) { toast in
//            toast.toastState = "danger"
//            toast.label = "Danger – slide, top, indefinite. Use manual dismiss."
//            toast.configureButton { btn in
//                btn.label = "Close"
//            }
//        }
//    }
//    
//    // 6 – Custom BG, label color, font size/weight
//    @objc func test_DSButton_CustomColors() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("DSButton tapped – test 6") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Custom BG #3D3D3D, white label, fontSize 14 bold"
//            toast.bgColor = UIColor(red: 61/255, green: 61/255, blue: 61/255, alpha: 1)
//            toast.labelColor = .white
//            toast.fontSize = 14
//            toast.fontWeight = "bold"
//            toast.configureButton { btn in
//                btn.label = "Got it"
//                btn.labelColor = .yellow
//            }
//        }
//    }
//    
//    // 7 – Custom leading icon, tint, size
//    @objc func test_DSButton_CustomIcon() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("DSButton tapped – test 7") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Custom icon: checkmark, tint yellow, size 20"
//            toast.iconLeading = UIImage(systemName: "checkmark.circle.fill")
//            toast.iconTintLeading = .yellow
//            toast.iconSize = 20
//            toast.configureButton { btn in
//                btn.label = "Nice"
//            }
//        }
//    }
//    
//    // 8 – Custom padding, spacing, corner radius
//    @objc func test_DSButton_CustomPadding() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("DSButton tapped – test 8") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Padding T/B:8, L/R:24, spacing:16, radius:20"
//            toast.paddingTop = 8
//            toast.paddingBottom = 8
//            toast.paddingLeading = 24
//            toast.paddingTrailing = 24
//            toast.spacing = 16
//            toast.cornerRadius = 20
//            toast.configureButton { btn in
//                btn.label = "OK"
//            }
//        }
//    }
//    
//    // 9 – Custom shadow
//    @objc func test_DSButton_CustomShadow() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("DSButton tapped – test 9") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Custom shadow: opacity 0.8, radius 10, offset(4,4), red"
//            toast.shadowOpacity = 0.8
//            toast.shadowRadius = 10
//            toast.shadowOffset = CGSize(width: 4, height: 4)
//            toast.shadowColor = .red
//            toast.configureButton { btn in
//                btn.label = "Shadow!"
//            }
//        }
//    }
//    
//    // 10 – Custom border
//    @objc func test_DSButton_CustomBorder() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("DSButton tapped – test 10") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Custom border: width 2, color yellow"
//            toast.borderWidth = 2
//            toast.borderColor = .yellow
//            toast.configureButton { btn in
//                btn.label = "Border!"
//            }
//        }
//    }
//    
//    // 11 – Swipe horizontal
//    @objc func test_DSButton_SwipeHorizontal() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .indefinite,
//            offsetY: .bottom(60),
//            swipeDirection: .horizontal,
//            onButtonTap: { print("DSButton tapped – test 11") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Swipe RIGHT to dismiss"
//            toast.configureButton { btn in
//                btn.label = "Or tap"
//            }
//        }
//    }
//    
//    // 12 – Swipe vertical bottom
//    @objc func test_DSButton_SwipeVerticalBottom() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .indefinite,
//            offsetY: .bottom(60),
//            swipeDirection: .vertical,
//            onButtonTap: { print("DSButton tapped – test 12") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Swipe DOWN to dismiss (bottom)"
//            toast.configureButton { btn in
//                btn.label = "Or tap"
//            }
//        }
//    }
//    
//    // 13 – Swipe vertical top
//    @objc func test_DSButton_SwipeVerticalTop() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .indefinite,
//            offsetY: .top(16),
//            swipeDirection: .vertical,
//            onButtonTap: { print("DSButton tapped – test 13") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Swipe UP to dismiss (top)"
//            toast.configureButton { btn in
//                btn.label = "Or tap"
//            }
//        }
//    }
//    
//    // 14 – Attributed label
//    @objc func test_DSButton_AttributedLabel() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("DSButton tapped – test 14") }
//        ) { toast in
//            toast.toastState = "info"
//            let attr = NSMutableAttributedString(string: "Bold ")
//            attr.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 14), range: NSRange(location: 0, length: 4))
//            let normal = NSAttributedString(string: "and normal text")
//            attr.append(normal)
//            toast.labelAttributed = attr
//            toast.configureButton { btn in
//                btn.label = "Attr!"
//            }
//        }
//    }
//    
//    // 15 – Wide horizontal padding
//    @objc func test_DSButton_HorizontalPaddingWide() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            horizontalPadding: 48,
//            onButtonTap: { print("DSButton tapped – test 15") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "HorizontalPadding = 48 (narrow toast)"
//            toast.configureButton { btn in
//                btn.label = "OK"
//            }
//        }
//    }
//    
//    // 16 – No icon
//    @objc func test_DSButton_NoIcon() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("DSButton tapped – test 16") }
//        ) { toast in
//            toast.toastState = "danger"
//            toast.label = "Danger without leading icon"
//            // iconLeading intentionally not set
//            toast.configureButton { btn in
//                btn.label = "Fix"
//                btn.btnType = "Secondary"
//            }
//        }
//    }
//    
//    // =========================================================================
//    // MARK: - IconButton Tests
//    // =========================================================================
//    
//    // 17
//    @objc func test_IconButton_Info_Fade_Bottom_Short() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .short,
//            horizontalPadding: 16,
//            offsetY: .bottom(60),
//            animation: .fade,
//            swipeDirection: .horizontal,
//            onButtonTap: { print("IconButton tapped – test 17") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Info toast with IconButton – fade, bottom, short"
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "xmark")
//            }
//        }
//    }
//    
//    // 18
//    @objc func test_IconButton_Danger_Fade_Bottom_Long() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            horizontalPadding: 16,
//            offsetY: .bottom(60),
//            animation: .fade,
//            swipeDirection: .horizontal,
//            onButtonTap: { print("IconButton tapped – test 18") }
//        ) { toast in
//            toast.toastState = "danger"
//            toast.label = "Danger toast with IconButton – fade, bottom, long"
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "exclamationmark.triangle.fill")
//            }
//        }
//    }
//    
//    // 19
//    @objc func test_IconButton_Info_Slide_Bottom_Custom() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .custom(4),
//            horizontalPadding: 16,
//            offsetY: .bottom(60),
//            animation: .slide,
//            swipeDirection: .horizontal,
//            onButtonTap: { print("IconButton tapped – test 19") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "IconButton – slide, bottom, custom 4s"
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "arrow.clockwise")
//            }
//        }
//    }
//    
//    // 20
//    @objc func test_IconButton_Info_Fade_Top_Short() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .short,
//            horizontalPadding: 16,
//            offsetY: .top(16),
//            animation: .fade,
//            swipeDirection: .vertical,
//            onButtonTap: { print("IconButton tapped – test 20") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "IconButton – fade, top, short"
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "bell.fill")
//            }
//        }
//    }
//    
//    // 21
//    @objc func test_IconButton_Danger_Slide_Top_Indefinite() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .indefinite,
//            horizontalPadding: 16,
//            offsetY: .top(16),
//            animation: .slide,
//            swipeDirection: .vertical,
//            onButtonTap: { print("IconButton tapped – test 21") }
//        ) { toast in
//            toast.toastState = "danger"
//            toast.label = "Danger IconButton – slide, top, indefinite"
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "xmark.circle.fill")
//            }
//        }
//    }
//    
//    // 22 – Custom colors + font
//    @objc func test_IconButton_CustomColors() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("IconButton tapped – test 22") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Custom BG purple, orange label, fontSize 13 semibold"
//            toast.bgColor = UIColor.purple
//            toast.labelColor = .orange
//            toast.fontSize = 13
//            toast.fontWeight = "semibold"
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "star.fill")
//                btn.iconTint = .orange
//            }
//        }
//    }
//    
//    // 23 – Custom leading icon for toast + IconButton icon/tint/size
//    @objc func test_IconButton_CustomLeadingIcon() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("IconButton tapped – test 23") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Toast icon: wifi, tint green, size 20. Button: xmark"
//            toast.iconLeading = UIImage(systemName: "wifi")
//            toast.iconTintLeading = .green
//            toast.iconSize = 20
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "xmark")
//                btn.iconTint = .white
//                btn.iconSize = 20
//                btn.btnSize = "Large"
//            }
//        }
//    }
//    
//    // 24 – Custom padding, spacing, corner radius
//    @objc func test_IconButton_CustomPadding() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("IconButton tapped – test 24") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Padding T/B:8, L/R:24, spacing:16, radius:24"
//            toast.paddingTop = 8
//            toast.paddingBottom = 8
//            toast.paddingLeading = 24
//            toast.paddingTrailing = 24
//            toast.spacing = 16
//            toast.cornerRadius = 24
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "checkmark")
//            }
//        }
//    }
//    
//    // 25 – Custom shadow
//    @objc func test_IconButton_CustomShadow() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("IconButton tapped – test 25") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Shadow: opacity 0.9, radius 12, offset(6,6), blue"
//            toast.shadowOpacity = 0.9
//            toast.shadowRadius = 12
//            toast.shadowOffset = CGSize(width: 6, height: 6)
//            toast.shadowColor = .blue
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "moon.fill")
//            }
//        }
//    }
//    
//    // 26 – Custom border
//    @objc func test_IconButton_CustomBorder() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("IconButton tapped – test 26") }
//        ) { toast in
//            toast.toastState = "danger"
//            toast.label = "Border: width 2, color cyan"
//            toast.borderWidth = 2
//            toast.borderColor = .cyan
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "xmark")
//            }
//        }
//    }
//    
//    // 27 – Swipe horizontal
//    @objc func test_IconButton_SwipeHorizontal() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .indefinite,
//            offsetY: .bottom(60),
//            swipeDirection: .horizontal,
//            onButtonTap: { print("IconButton tapped – test 27") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Swipe RIGHT to dismiss"
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "arrow.right")
//            }
//        }
//    }
//    
//    // 28 – Swipe vertical bottom
//    @objc func test_IconButton_SwipeVerticalBottom() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .indefinite,
//            offsetY: .bottom(60),
//            swipeDirection: .vertical,
//            onButtonTap: { print("IconButton tapped – test 28") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Swipe DOWN to dismiss (bottom)"
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "arrow.down")
//            }
//        }
//    }
//    
//    // 29 – Swipe vertical top
//    @objc func test_IconButton_SwipeVerticalTop() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .indefinite,
//            offsetY: .top(16),
//            swipeDirection: .vertical,
//            onButtonTap: { print("IconButton tapped – test 29") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "Swipe UP to dismiss (top)"
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "arrow.up")
//            }
//        }
//    }
//    
//    // 30 – Attributed label
//    @objc func test_IconButton_AttributedLabel() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("IconButton tapped – test 30") }
//        ) { toast in
//            toast.toastState = "info"
//            let attr = NSMutableAttributedString(string: "Italic ")
//            attr.addAttribute(.font, value: UIFont.italicSystemFont(ofSize: 13), range: NSRange(location: 0, length: 6))
//            let colored = NSAttributedString(
//                string: "colored text",
//                attributes: [.foregroundColor: UIColor.yellow, .font: UIFont.systemFont(ofSize: 13)]
//            )
//            attr.append(colored)
//            toast.labelAttributed = attr
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "textformat")
//            }
//        }
//    }
//    
//    // 31 – IconButton Secondary type
//    @objc func test_IconButton_SecondaryType() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("IconButton tapped – test 31") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "IconButton btnType = Secondary"
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "info.circle")
//                btn.btnType = "Secondary"
//                btn.btnSize = "Medium"
//            }
//        }
//    }
//    
//    // 32 – IconButton Tertiary type
//    @objc func test_IconButton_TertiaryType() {
//        ToastManager.instance.show(
//            rootView: rootView,
//            duration: .long,
//            onButtonTap: { print("IconButton tapped – test 32") }
//        ) { toast in
//            toast.toastState = "info"
//            toast.label = "IconButton btnType = Tertiary"
//            toast.configureIconButton { btn in
//                btn.icon = UIImage(systemName: "gearshape")
//                btn.btnType = "Tertiary"
//                btn.btnSize = "Medium"
//            }
//        }
//    }
//    
//    // =========================================================================
//    // MARK: - Manual Dismiss
//    // =========================================================================
//    
//    // 33
//    @objc func test_ManualDismissAnimated() {
//        ToastManager.instance.dismiss(animated: true)
//        print("Dismissed with animation")
//    }
//    
//    // 34
//    @objc func test_ManualDismissNotAnimated() {
//        ToastManager.instance.dismiss(animated: false)
//        print("Dismissed without animation")
//    }
//}
