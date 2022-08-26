//
//  RearViewController.swift
//  HamburgerMenu
//
//  Created by Mohanmed Melek Chtourou on 15/08/22
//  Copyright © 2018 Big Rattle Technologies Private Limited. All rights reserved.
//

import UIKit

class Drawer: UIViewController, UITableViewDelegate,UITableViewDataSource {
    let menu = ["Accueil","Faculty Desk","HandBook","Enseignants","Responsables Pedagogiaues","Services","Parametres","Se Deconnecter"]
    var window: UIWindow?
    
    var firstCategory = 6
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 6
        }
        else{
            return 2
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Actualité"
        }else{
            return "Autres"
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView{
            header.textLabel?.textColor = .red
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "drawerCell", for: indexPath)
        let cv = cell.contentView
        let logo = cv.viewWithTag(1) as! UIImageView
        logo.image?.withTintColor(UIColor.black)
        logo.tintColor = UIColor.label
        let text = cv.viewWithTag(2) as! UILabel
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                logo.image = UIImage(systemName: "house.fill")
            case 1:
                logo.image = UIImage(systemName: "building")
            case 2:
                logo.image = UIImage(systemName: "folder.fill")
            case 3:
                logo.image = UIImage(systemName: "person.2.fill")
            case 4:
                logo.image = UIImage(systemName: "person.fill")
            case 5:
                logo.image = UIImage(systemName: "info.circle.fill")
            default:
                logo.image = UIImage(systemName: "house.fill")
            }
            text.text = menu[indexPath.row]
        }
        else if indexPath.section == 1{
            switch firstCategory {
            case 6:
                logo.image = UIImage(systemName: "gearshape.fill")
            case 7:
                logo.image = UIImage(systemName: "rectangle.righthalf.inset.filled.arrow.right")
            default:
                logo.image = UIImage(systemName: "house.fill")
            }
            text.text = menu[firstCategory]
            firstCategory += 1
            
        }
        
        return cell
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                HamburgerMenu().closeSideMenu()
            case 3:
                performSegue(withIdentifier: "DepartementSegue", sender: nil)
            case 4:
                performSegue(withIdentifier: "segueResponsablePU", sender: nil)
            case 5:
                performSegue(withIdentifier: "segueServices", sender: nil)
            default:
                print("okay")
            }
        } else{
            switch indexPath.row {
            case 0:
                print("okay")
            default:
                self.dismiss(animated: true)
                UserDefaults.standard.removeObject(forKey: "name")
                performSegue(withIdentifier: "logout", sender: nil)
            }
        }
    }

}
