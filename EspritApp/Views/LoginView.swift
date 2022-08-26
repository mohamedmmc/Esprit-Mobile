//
//  ViewController.swift
//  EspritMobileApp
//
//  Created by Mohamed Melek Chtourou on 29/7/2022.
//

import UIKit

class LoginView: UIViewController {
    
    //Outlets
    @IBOutlet weak var card: UIView!
    @IBOutlet weak var name: UITextField!
    
    //Actions
    @IBAction func login(_ sender: Any) {
        if (!(name.text ?? "").isEmpty) {
            UserDefaults.standard.set(name.text!, forKey: "name")
            performSegue(withIdentifier: "login", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        card.layer.cornerRadius = 20
        card.layer.shadowRadius = 2
        card.layer.shadowOpacity = 1.0
        card.layer.shadowOffset = CGSize(width: -1, height: 1)
        card.layer.shadowColor = UIColor.gray.cgColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

