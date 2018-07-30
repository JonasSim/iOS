//
//  TasksCustomTableViewCell.swift
//  Courseworks Manager
//
//  Created by Jonas Simonaitis on 17/05/2018.
//  Copyright © 2018 Jonas Simonaitis. All rights reserved.
//

import UIKit

class TasksCustomTableViewCell: UITableViewCell {

    // Code REFERENCE --------------- from Mobile Native Application Development Lectures week 11 and Master Detail
    
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskDaysLeftLabel: UILabel!
    @IBOutlet weak var taskCompletedLabel: UILabel!
    @IBOutlet weak var taskNotesView: UITextView!
    @IBOutlet weak var customeProgressBar: ProgressBarView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func editTaskButton(_ sender: UIButton) {
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
