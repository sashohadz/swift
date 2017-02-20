//
//  AddItemViewController.swift
//  exam
//
//  Created by Sasho Hadzhiev on 2/18/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var recepientNameTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var favouriteColorTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var luxurySlider: UISlider!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var orderButton: UIBarButtonItem!
    
    var dataDictionary:[String:Any?] = [String:Any?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.recepientNameTextField.delegate = self
        self.genderTextField.delegate = self
        self.fromTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.priceLabel.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.recepientNameTextField:
            self.genderTextField.becomeFirstResponder()
        case self.genderTextField:
            self.favouriteColorTextField.becomeFirstResponder()
        case self.favouriteColorTextField:
            self.messageTextView.becomeFirstResponder()
        case self.messageTextView:
            self.fromTextField.becomeFirstResponder()
        case self.fromTextField:
            textField.resignFirstResponder()
        default:
            break
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.priceLabel.text = calculatePrice()
        self.priceLabel.isHidden = false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }

    func calculatePrice() -> String {
        
        let messageTextCount = self.messageTextView.text?.characters.count
        let senderCount = self.fromTextField.text?.characters.count
        let sliderCount = Double(self.luxurySlider.value)
        let textCountPrice = ((Double(messageTextCount!) + Double(senderCount!)) * 0.1) + 2.0
        let luxuryBasedPrice = 1.0 + (0.1 * sliderCount)
        let price = textCountPrice * luxuryBasedPrice
        return String(format:"$%.1f", price)
    }
    
    @IBAction func sliderButtonMoved(_ sender: UISlider) {
        self.priceLabel.text = calculatePrice()
    }

    @IBAction func orderButtonPressed(_ sender: UIBarButtonItem) {
        dataDictionary[DataNames.receiver.rawValue] = self.recepientNameTextField.text
        dataDictionary[DataNames.gender.rawValue] = self.genderTextField.text
        dataDictionary[DataNames.favouriteColor.rawValue] = self.favouriteColorTextField.text
        dataDictionary[DataNames.message.rawValue] = self.messageTextView.text
        dataDictionary[DataNames.sender.rawValue] = self.fromTextField.text
        dataDictionary[DataNames.luxuryLevel.rawValue] = self.luxurySlider.value
        dataDictionary[DataNames.price.rawValue] = self.priceLabel.text
        DataCommunication.instance.placeNewOrder(info: self.dataDictionary)
        _ = self.navigationController?.popToRootViewController(animated: true)
    }
}
