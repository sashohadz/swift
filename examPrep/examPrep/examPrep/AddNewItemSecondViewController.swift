//
//  AddNewItemSecondViewController.swift
//  examPrep
//
//  Created by Sasho Hadzhiev on 2/16/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class AddNewItemSecondViewController: UIViewController {

    @IBOutlet weak var firstSlider: UISlider!
    @IBOutlet weak var secondSlider: UISlider!
    @IBOutlet weak var thirdSlider: UISlider!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var thirdLabel: UILabel!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var dataDictionary:[String:Any?] = [String:Any?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func doneButtonClicked(_ sender: UIBarButtonItem) {
        self.dataDictionary[DataNames.value1.rawValue] = self.firstSlider.value
        self.dataDictionary[DataNames.value2.rawValue] = self.secondSlider.value
        self.dataDictionary[DataNames.value3.rawValue] = self.thirdSlider.value
        
        DBCommunication.instance.sendInfoToDB(info: self.dataDictionary)
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
}
