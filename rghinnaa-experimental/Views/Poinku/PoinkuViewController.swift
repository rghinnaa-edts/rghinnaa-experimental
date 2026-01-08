//
//  PoinkuViewController.swift
//  rghinnaa-experimental
//
//  Created by Rizka Ghinna Auliya on 26/09/25.
//

import UIKit

class PoinkuViewController: UITableViewController {
    
    private var sections = ["Components", "Pages"]
    
    private var componentList: [String] = [
        "Card",
        "Coachmark",
        "MGM Card Animation",
        "Progress Bar",
        "Ribbon",
        "Scrolling Animation",
        "Skeleton"
    ]
    
    private var pageList: [String] = [
        "Home Page",
        "OnBoarding Page",
        "Poin Loyalty Page",
        "Profile Page",
        "Register Page",
        "Stamp Page",
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
        case "Card":
            let vc = UIStoryboard(name: "CardViewController", bundle: nil).instantiateViewController(withIdentifier: "Card")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Coachmark":
            let vc = UIStoryboard(name: "CoachmarkViewController", bundle: nil).instantiateViewController(withIdentifier: "Coachmark")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "MGM Card Animation":
            let vc = UIStoryboard(name: "MGMViewController", bundle: nil).instantiateViewController(withIdentifier: "MGMCardPage")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Ribbon":
            let vc = UIStoryboard(name: "RibbonViewController", bundle: nil).instantiateViewController(withIdentifier: "Ribbon")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Scrolling Animation":
            let vc = UIStoryboard(name: "ScrollingViewController", bundle: nil).instantiateViewController(withIdentifier: "Scrolling")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Skeleton":
            let vc = UIStoryboard(name: "SkeletonViewController", bundle: nil).instantiateViewController(withIdentifier: "Skeleton")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Home Page":
            let vc = UIStoryboard(name: "HomeViewController", bundle: nil).instantiateViewController(withIdentifier: "HomePage")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "OnBoarding Page":
            let vc = UIStoryboard(name: "OnBoardingViewController", bundle: nil).instantiateViewController(withIdentifier: "OnBoardingPage")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Poin Loyalty Page":
            let vc = UIStoryboard(name: "PoinLoyaltyPageViewController", bundle: nil).instantiateViewController(withIdentifier: "PoinLoyaltyPage")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Profile Page":
            let vc = UIStoryboard(name: "ProfileViewController", bundle: nil).instantiateViewController(withIdentifier: "ProfilePage")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Register Page":
            let vc = UIStoryboard(name: "Register1ViewController", bundle: nil).instantiateViewController(withIdentifier: "Register1Page")
            navigationController?.pushViewController(vc, animated: true)
        break
        case "Stamp Page":
            let vc = UIStoryboard(name: "StampPageViewController", bundle: nil).instantiateViewController(withIdentifier: "StampPage")
            navigationController?.pushViewController(vc, animated: true)
        break
        default:
            let vc = UIStoryboard(name: "DoubleArcViewController", bundle: nil).instantiateViewController(withIdentifier: "DoubleArc")
            navigationController?.pushViewController(vc, animated: true)
        break
        }
    }

}

