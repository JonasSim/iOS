//
//  TopCourseworkViewController.swift
//  Courseworks Manager
//
//  Created by Jonas Simonaitis on 14/05/2018.
//  Copyright © 2018 Jonas Simonaitis. All rights reserved.
//

import UIKit

class TopCourseworkViewController: UIViewController {
   
    
    @IBOutlet weak var labelModuleName: UILabel!
    @IBOutlet weak var labelWeight: UILabel!
    @IBOutlet weak var labelLevel: UILabel!
    @IBOutlet weak var labelMark: UILabel!
    @IBOutlet weak var labelCompleteProgress: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var notesField: UITextView!
    @IBOutlet weak var customProgressBar: ProgressBarView!
    
    // CODE REFERENCE: https://www.youtube.com/watch?v=bmAYYVYzeXk&t=624s
    
    var levelLbl: String?
    var moduleNameLbl: String?
    var weightLbl: String?
    var notesFieldLbl: String?
    var completeLbl: Double?
    var markLbl: String?
    var progressBarCalculated: Double?
    
    // -------- END
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelModuleName.text = moduleNameLbl
        
        if weightLbl != nil && levelLbl != nil && markLbl != nil {
            
            labelWeight.text = "Weight: \(weightLbl!)%"
            labelLevel.text = "Level: \(levelLbl!)"
            labelMark.text = "Mark: \(markLbl!)/100"
        
        }
        
        labelCompleteProgress.text = "\(completeLbl ?? 0)% Completed"
        if(progressBarCalculated != nil){
        //progressBar.progress = Float(progressBarCalculated!)/100
        customProgressBar.progress = CGFloat(progressBarCalculated!)/100
        }
        notesField.text = notesFieldLbl
        
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
