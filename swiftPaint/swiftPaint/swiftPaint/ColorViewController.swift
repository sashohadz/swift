//
//  ColorViewController.swift
//  swiftPaint
//
//  Created by Sasho Hadzhiev on 1/21/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    @IBOutlet weak var alphaSlider: UISlider!
    @IBOutlet weak var stepperSize: UIStepper!
    @IBOutlet weak var sizeLabel: UILabel!
    
    var redColor: CGFloat = 0
    var greenColor: CGFloat = 0
    var blueColor: CGFloat = 0
    var alphaValue: CGFloat = 1.0
    var drawingColor:UIColor = UIColor.blue
    var colorOptions = DrawingOptions()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.sizeLabel.text = String(4)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // The color of the thumb is changed to repsesent the selected RGB value.
    // The color of the size text is adjusted to the selected overall color.
    // We also send the current color to the DrowingOptions model.
    @IBAction func sliderChanged(_ sender: UISlider) {
        switch sender{
        case self.redSlider:
            redColor = CGFloat(sender.value);
            self.redSlider.thumbTintColor = UIColor(red: redColor, green: 0, blue: 0, alpha: 1.0)
        case self.greenSlider:
            greenColor = CGFloat(sender.value);
            self.greenSlider.thumbTintColor = UIColor(red: 0, green: greenColor, blue: 0, alpha: 1.0)
        case self.blueSlider:
            blueColor = CGFloat(sender.value);
            self.blueSlider.thumbTintColor = UIColor(red: 0, green: 0, blue: blueColor, alpha: 1.0)
        case self.alphaSlider:
            alphaValue = CGFloat(sender.value);
            self.alphaSlider.thumbTintColor = UIColor(red: 0.189, green: 0.195, blue: 0.199, alpha: alphaValue)
        default:
            break
        }
        drawingColor = UIColor(red: redColor, green: greenColor, blue: blueColor, alpha: alphaValue)
        self.sizeLabel.textColor = drawingColor
        self.colorOptions.currentColor = self.drawingColor
    }
    
    // Stepper to change the line width and send it to the model.
    @IBAction func stepperChanged(_ sender: UIStepper) {
        self.sizeLabel.text = String(Int(sender.value))
        self.colorOptions.lineWidth = sender.value
    }
}
