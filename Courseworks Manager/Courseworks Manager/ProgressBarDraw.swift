//
//  ProgressBarDraw.swift
//  Courseworks Manager
//
//  Created by Jonas Simonaitis on 21/05/2018.
//  Copyright © 2018 Jonas Simonaitis. All rights reserved.
//

import Foundation
import UIKit

public class ProgressBarDraw : NSObject {
    
    // Code reference: https://www.youtube.com/watch?v=UtVNxFMzGXw
    
    public class func drawProgressBar(frame: CGRect = CGRect(x: 0, y: 0, width: 300, height: 14), progress: CGFloat = 183) {
        
        // Colour Declarations
        let color = UIColor(red: 0.847, green: 0.278, blue: 0.118, alpha: 1.000)
        
        // Border Drawing
        let progressBorderPath = UIBezierPath(roundedRect: CGRect(x: frame.minX + 1, y: frame.minY + 1, width: floor((frame.width - 1) * 0.99666 + 0.5), height: 14), cornerRadius: 7)
        
        color.setStroke()
        progressBorderPath.lineWidth = 1
        progressBorderPath.stroke()
        
        //Progress Active Drawing
        
        let progressActivePath = UIBezierPath(roundedRect: CGRect(x: 1, y:1, width: progress, height: 14), cornerRadius: 7)
        color.setFill()
        progressActivePath.fill()
        
    }
    
    
    
}
