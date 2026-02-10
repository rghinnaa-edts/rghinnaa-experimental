//
//  KlikViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 13/10/25.
//

import UIKit

class KlikViewController: UITableViewController {
    
    private var sections = ["Components", "Pages"]
    
    private var componentList: [String] = [
        "Badge",
        "Button",
        "Icon Button",
        "Chip",
        "Card My Coupon",
        "Toast"
    ]
    
    private var pageList: [String] = [
        "Cart Page",
        "Coupon Offered Page",
        "Product Detail Page",
        "Promo Gift Page",
        "Search Page"
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.navigationController?.setToolbarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return componentList.count
        } else {
            return pageList.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComponentCell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.textLabel?.text = componentList[indexPath.row]
        } else {
            cell.textLabel?.text = pageList[indexPath.row]
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    private func setupUI() {
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
                
        let selectedItem: String
        if indexPath.section == 0 {
            selectedItem = componentList[indexPath.row]
        } else {
            selectedItem = pageList[indexPath.row]
        }
        
        navigateToPage(for: selectedItem)
    }
    
    private func navigateToPage(for item: String) {
        
        switch item {
        case "Badge":
            let vc = UIStoryboard(name: "BadgeViewController", bundle: nil).instantiateViewController(withIdentifier: "BadgePage")
            navigationController?.pushViewController(vc, animated: true)
        case "Button":
            let vc = UIStoryboard(name: "ButtonViewController", bundle: nil).instantiateViewController(withIdentifier: "ButtonPage")
            navigationController?.pushViewController(vc, animated: true)
        case "Icon Button":
            let vc = UIStoryboard(name: "IconButtonViewController", bundle: nil).instantiateViewController(withIdentifier: "IconButtonPage")
            navigationController?.pushViewController(vc, animated: true)
        case "Chip":
            let vc = UIStoryboard(name: "ChipViewController", bundle: nil).instantiateViewController(withIdentifier: "ChipPage")
            navigationController?.pushViewController(vc, animated: true)
        case "Card My Coupon":
            let vc = UIStoryboard(name: "CardMyCouponViewController", bundle: nil).instantiateViewController(withIdentifier: "CardMyCouponPage")
            navigationController?.pushViewController(vc, animated: true)
        case "Toast":
            let vc = UIStoryboard(name: "ToastViewController", bundle: nil).instantiateViewController(withIdentifier: "ToastPage")
            navigationController?.pushViewController(vc, animated: true)
        case "Cart Page":
            let vc = UIStoryboard(name: "CartViewController", bundle: nil).instantiateViewController(withIdentifier: "CartPage")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Coupon Offered Page":
            let vc = UIStoryboard(name: "CouponOfferedViewController", bundle: nil).instantiateViewController(withIdentifier: "CouponOfferedPage")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Product Detail Page":
            let vc = UIStoryboard(name: "PDPViewController", bundle: nil).instantiateViewController(withIdentifier: "PDPPage")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Promo Gift Page":
            let vc = UIStoryboard(name: "PromoGiftViewController", bundle: nil).instantiateViewController(withIdentifier: "PromoGiftPage")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Search Page":
            let vc = UIStoryboard(name: "SearchViewController", bundle: nil).instantiateViewController(withIdentifier: "SearchPage")
            navigationController?.pushViewController(vc, animated: true)
        break
        default:
            let vc = UIStoryboard(name: "CardViewController", bundle: nil).instantiateViewController(withIdentifier: "Card")
            navigationController?.pushViewController(vc, animated: true)
        break
        }
    }
}
