//
//  AddNewItemFirstViewController.swift
//  examPrep
//
//  Created by Sasho Hadzhiev on 2/16/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class AddNewItemFirstViewController: UIViewController {

    @IBOutlet weak var deviceTextField: UITextField!
    @IBOutlet weak var deviceNameTextField: UITextField!
    @IBOutlet weak var ledWorkingSwitch: UISwitch!
    @IBOutlet weak var displayWorkingSwitch: UISwitch!
    @IBOutlet weak var buzzerWorkingSwitch: UISwitch!
    @IBOutlet weak var buttonWorkingSwitch: UISwitch!
    
    var dataDictionary:[String:Any?] = [String:Any?]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        dataDictionary[DataNames.deviceId.rawValue] = self.deviceTextField.text
        dataDictionary[DataNames.deviceNmae.rawValue] = self.deviceNameTextField.text
        dataDictionary[DataNames.ledWorking.rawValue] = self.ledWorkingSwitch.isOn
        dataDictionary[DataNames.displayWorking.rawValue] = self.displayWorkingSwitch.isOn
        dataDictionary[DataNames.buzzerWorking.rawValue] = self.buzzerWorkingSwitch.isOn
        dataDictionary[DataNames.buttonWorking.rawValue] = self.buttonWorkingSwitch.isOn
        
        if segue.identifier == "ToAddDetailsSegue" {
        let destination = segue.destination as! AddNewItemSecondViewController
        destination.dataDictionary = self.dataDictionary
        }
    }
    

}
