//
//  CourseworkCustomTableViewCell.swift
//  Courseworks Manager
//
//  Created by Jonas Simonaitis on 14/05/2018.
//  Copyright © 2018 Jonas Simonaitis. All rights reserved.
//

import UIKit
import CoreData

class CourseworkCustomTableViewCell: UITableViewCell, UITableViewDelegate {
    
    
    @IBOutlet weak var courseworkLabel2: UILabel!
    @IBOutlet weak var weightLabel2: UILabel!
    @IBOutlet weak var moduleNameLabel2: UILabel!
    @IBOutlet weak var levelLabel2: UILabel!
    @IBOutlet weak var duedateLabel2: UILabel!
    @IBOutlet weak var leftDaysLabel2: UILabel!
    @IBOutlet weak var progressBar2: UIProgressView!
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }

}
