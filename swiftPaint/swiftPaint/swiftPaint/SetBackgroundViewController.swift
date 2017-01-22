//
//  SetBackgroundViewController.swift
//  swiftPaint
//
//  Created by Sasho Hadzhiev on 1/22/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class SetBackgroundViewController: UIViewController {

    @IBOutlet weak var setWhiteBack: UIButton!
    @IBOutlet weak var setBlackBack: UIButton!
    @IBOutlet weak var clearAll: UIButton!
    
    var colorOptions = DrawingOptions()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func backgroundButtonClicked(_ sender: UIButton) {
        
        switch sender {
        case self.setBlackBack:
            self.colorOptions.currentBackgroundColor = UIColor.black
        case self.setWhiteBack:
            self.colorOptions.currentBackgroundColor = UIColor.white
        case self.clearAll:
            self.colorOptions.clearAll = true
        default:
            break
        }
    }
}
