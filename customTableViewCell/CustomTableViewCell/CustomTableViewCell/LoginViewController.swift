//
//  LoginViewController.swift
//  CustomTableViewCell
//
//  Created by Sasho Hadzhiev on 2/7/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit
import Leanplum

enum UserCheckResult{
    case OK, Short, Empty
}

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginDetailslabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNameTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.resultLabel.isHidden = true
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.profileImageView.image = appDelegate.profileImage?.imageValue()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userNameTextField.resignFirstResponder()
        return true
    }

    func checkUser() -> UserCheckResult {
        guard self.userNameTextField.text != nil else {return .Empty}
        if self.userNameTextField.text!.characters.count < 3 {
            return .Short
        }
        
        return .OK
    }

    func evaluateUserAndPresentResult() {
        switch self.checkUser() {
        case .OK:
            let userNameValue = userNameTextField.text! as String
            self.resultLabel.textColor = UIColor.green
            Leanplum.setUserId(userNameValue)
            self.resultLabel.text = "Logged in as \(userNameValue)"
        case .Empty:
            self.resultLabel.textColor = UIColor.red
            self.resultLabel.text = "Empty username"
        case .Short:
            self.resultLabel.textColor = UIColor.red
            self.resultLabel.text = "Username too short"
        }
        
        self.resultLabel.isHidden = false
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        evaluateUserAndPresentResult()
    }
}
