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
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        // TO do
    }
    
    @IBAction func doneButtonClicked(_ sender: UIBarButtonItem) {
        self.dataDictionary[DataNames.value1.rawValue] = self.firstSlider.value
        self.dataDictionary[DataNames.value2.rawValue] = self.secondSlider.value
        self.dataDictionary[DataNames.value3.rawValue] = self.thirdSlider.value
        
        DBCommunication.instance.sendInfoToDB(info: self.dataDictionary)
        _ = self.navigationController?.popToRootViewController(animated: true)
    }

}
