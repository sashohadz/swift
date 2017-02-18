//
//  RegisterViewController.swift
//  exam
//
//  Created by Sasho Hadzhiev on 2/18/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyPasswordTextField: UITextField!
    @IBOutlet weak var gsmNumberTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    var dataDictionary:[String:Any?] = [String:Any?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        let name = nameTextField.text
        let username = userNameTextField.text
        let password = passwordTextField.text
        let gsmNumber = gsmNumberTextField.text
        self.dataDictionary[UserDefaultKeys.username.rawValue] = username
        self.dataDictionary[UserDefaultKeys.name.rawValue] = name
        self.dataDictionary[UserDefaultKeys.password.rawValue] = password
        self.dataDictionary[UserDefaultKeys.gsmNumber.rawValue] = gsmNumber
        
        DataCommunication.instance.registerUser(info: self.dataDictionary)
        
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.autoLoginEnabled.rawValue)
        UserDefaults.standard.set(username, forKey: UserDefaultKeys.username.rawValue)
        UserDefaults.standard.set(password, forKey: UserDefaultKeys.password.rawValue)
        
        self.modalTransitionStyle = .crossDissolve
        self.present(UIStoryboard.init(name: "Main", bundle: nil).instantiateInitialViewController()!, animated: true, completion: nil)
    }

}
