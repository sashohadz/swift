//
//  ViewController.swift
//  exam
//
//  Created by Sasho Hadzhiev on 2/18/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {


    @IBOutlet weak var usernameTextFIeld: UITextField!
    @IBOutlet weak var passwordTextFIeld: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let username = UserDefaults.standard.string(forKey: UserDefaultKeys.username.rawValue) {
            self.usernameTextFIeld.text = username
        }
        if let password = UserDefaults.standard.string(forKey: UserDefaultKeys.password.rawValue) {
            self.passwordTextFIeld.text = password
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func userProfileButtonPressed(_ sender: UIButton) {
        
        let password = String(self.passwordTextFIeld.text!)!
        let username = self.usernameTextFIeld.text!
        
        switch sender {
        case self.loginButton:
            
            guard usernameTextFIeld.text!.characters.count > 0 else {
                let alert = UIAlertController.init(title: "Error", message: "Please enter a username.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            guard password.characters.count > 0 else {
                let alert = UIAlertController.init(title: "Error", message: "Please enter a password.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            DataCommunication.instance.login(with: username, password: password) { (success) in
                if success == true {
                    UserDefaults.standard.set(username, forKey: UserDefaultKeys.username.rawValue)
                    UserDefaults.standard.set(password, forKey: UserDefaultKeys.password.rawValue)
                    UserDefaults.standard.set(true, forKey: UserDefaultKeys.autoLoginEnabled.rawValue)
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "LoginToMainScreenSegue", sender: nil)
                    }
                }
                else {
                    let alert = UIAlertController.init(title: "Error", message: "Wrong username or passowrd.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: nil))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                }
            }
            
            
        case self.registerButton:
            performSegue(withIdentifier: "LoginToRegisterSegue", sender: self)
        default:
            break
        }
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "LoginToRegisterSegue" {
            _ = segue.destination as! RegisterViewController
        }
    }
}

