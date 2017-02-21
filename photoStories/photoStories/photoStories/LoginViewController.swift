//
//  LoginViewController.swift
//  photoStories
//
//  Created by Sasho Hadzhiev on 2/21/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButon: UIButton!
    @IBOutlet weak var registrationButton: UIButton!
    @IBOutlet weak var skipRegistrationButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        self.profileImageView.image = appDelegate.profileImage?.imageValue()
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
        
        let passwordString = String(self.passwordTextField.text!)
        
        DBCommunication.instance.login(with: self.usernameTextField.text!, password: passwordString!) { (success) in
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
    
    @IBAction func registrationButtonPressed(_ sender: UIButton) {
    }
    
}
