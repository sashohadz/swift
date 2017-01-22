//
//  DrawViewController.swift
//  swiftPaint
//
//  Created by Sasho Hadzhiev on 1/21/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var previousTouch: CGPoint?
    var colorOptions = DrawingOptions()
    var currentColor:UIColor = UIColor.black
    var backgroundColor:UIColor = UIColor.white
    var currentLineWidth = 4.0
    // We let the viewControllers share the same DrawingOptions model.
    override func viewDidLoad() {
        super.viewDidLoad()
        let barViewControllers = self.tabBarController?.viewControllers
        let svc = barViewControllers![1] as! ColorViewController
        svc.colorOptions = self.colorOptions
        let svc2 = barViewControllers![2] as! SetBackgroundViewController
        svc2.colorOptions = self.colorOptions
    }
    
    // We set the color each time the view appears.
    // We check if we need to clear the image or set background.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        currentLineWidth = colorOptions.lineWidth
        currentColor = colorOptions.getCurrentColor()
        self.imageView!.backgroundColor = colorOptions.getCurrentBackground()
        if (colorOptions.clearAll == true) {
            self.imageView!.image = nil
        }
        colorOptions.clearAll = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func drawLine(_ begining:CGPoint, end:CGPoint){
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        self.imageView!.image?.draw(in: self.view.frame)
        context?.move(to: begining)
        context?.addLine(to: end)
        context?.setLineWidth(CGFloat(currentLineWidth))
        context?.setStrokeColor(currentColor.cgColor)
        context?.setLineCap(.round)
        context?.strokePath()
        context?.setBlendMode(.normal)
        
        self.imageView!.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let lastTouch = touches.first
        let position = lastTouch?.location(in: self.imageView)
        self.previousTouch = position
        drawLine(self.previousTouch!, end: position!)
    }
    
    // TO DO: let touchForce = lastTouch?.force
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        let lastTouch = touches.first
        let position = lastTouch?.location(in: self.imageView)
        drawLine(self.previousTouch!, end: position!)
        self.previousTouch = position
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let lastTouch = touches.first
        let position = lastTouch?.location(in: self.imageView)
        drawLine(self.previousTouch!, end: position!)
    }
}

