//
//  ProgressBarView.swift
//  Courseworks Manager
//
//  Created by Jonas Simonaitis on 21/05/2018.
//  Copyright © 2018 Jonas Simonaitis. All rights reserved.
//

import UIKit

// Code reference: https://www.youtube.com/watch?v=UtVNxFMzGXw
// CODE UPDATED FOR THIS PROJECT

class ProgressBarView: UIView {

    private var _firstValue: CGFloat = 0.0
    
    var progress: CGFloat {
        set(newValue) {
            if newValue > 1.0 {
                _firstValue = 10
            } else if newValue > 11 {
                _firstValue = 20
            }else if newValue > 21 {
                _firstValue = 30
            }else if newValue > 31 {
                _firstValue = 40
            }else if newValue > 41 {
                _firstValue = 50
            }else if newValue > 51 {
                _firstValue = 60
            }else if newValue > 61 {
                _firstValue = 70
            }else if newValue > 71 {
                _firstValue = 80
            }else if newValue > 81 {
                _firstValue = 90
            }else if newValue > 94 {
                _firstValue = 95
            }else if newValue == 100 {
                _firstValue = 100
            } else {
                _firstValue = newValue
            }
            setNeedsDisplay()
        }
        
        get {
            return _firstValue * bounds.width
        }
    }
    override func draw(_ rect: CGRect) {
        ProgressBarDraw.drawProgressBar(frame: bounds, progress: progress)
    }
}
