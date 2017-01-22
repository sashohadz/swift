//
//  DrawingOptions.swift
//  swiftPaint
//
//  Created by Sasho Hadzhiev on 1/22/17.
//  Copyright © 2017 Sasho Hadzhiev. All rights reserved.
//

import UIKit

// Shared model to hold the drawint Options - color, background, size etc.
class DrawingOptions: NSObject {
    
    var currentColor:UIColor = UIColor.black
    var currentBackgroundColor:UIColor = UIColor.white
    var clearAll:Bool = false
    var lineWidth:Double = 4.0
    
    func getCurrentColor() -> UIColor {
        return currentColor
    }
    
    func getCurrentBackground() -> UIColor {
        return currentBackgroundColor
    }
    
    func getCurrentLineWidth() -> Double {
        return lineWidth
    }
}
