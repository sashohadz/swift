//
//  LoginViewController.swift
//  examPrep
//
//  Created by Sasho Hadzhiev on 2/16/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var loginLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let username = UserDefaults.standard.string(forKey: UserDefaultKeys.username.rawValue) {
            self.usernameTextField.text = username
        }
        if let password = UserDefaults.standard.string(forKey: UserDefaultKeys.password.rawValue) {
            self.passwordTextField.text = password
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        guard usernameTextField.text!.characters.count > 0 else {
            let alert = UIAlertController.init(title: "Error", message: "Please enter a username", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)

            return
        }
        
        let passwordHashString = String(self.passwordTextField.text!.hash)
        
        DBCommunication.instance.login(with: self.usernameTextField.text!, passwordHash: passwordHashString ) { (success) in
            if success == true {
                UserDefaults.standard.set(self.usernameTextField.text, forKey: UserDefaultKeys.username.rawValue)
                UserDefaults.standard.set(self.passwordTextField.text, forKey: UserDefaultKeys.password.rawValue)
                UserDefaults.standard.set(true, forKey: UserDefaultKeys.autoLoginEnabled.rawValue)
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "LoginCompletedSegue", sender: nil)
                }
            }
            else {
                let alert = UIAlertController.init(title: "Error", message: "Wrong username or passowrd", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
