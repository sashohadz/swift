//
//  ApplicationContainer.swift
//  exam
//
//  Created by Sasho Hadzhiev on 2/18/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class ApplicationContainer: UIViewController {

     var userLoggedIn:Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        
        if let autoUserLoginEnabled = UserDefaults.standard.object(forKey: UserDefaultKeys.autoLoginEnabled.rawValue) {
            self.userLoggedIn = autoUserLoginEnabled as? Bool
        }
        else {
            self.userLoggedIn = false
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if userLoggedIn == true {
            self.performSegue(withIdentifier: "ToMainScreenSegue", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "ToLoginSegue", sender: nil)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
