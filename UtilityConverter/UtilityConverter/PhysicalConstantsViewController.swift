//
//  PhysicalConstantsViewController.swift
//  UtilityConverter
//
//  Created by Meirunas on 2018-02-24.
//  Copyright © 2018 Meirunas. All rights reserved.
//

import UIKit

class PhysicalConstantsViewController: UIViewController {
    
    @IBOutlet weak var eletrconL: UILabel!
    @IBOutlet weak var protonL: UILabel!
    @IBOutlet weak var neutronL: UILabel!
    @IBOutlet weak var electricPL: UILabel!
    @IBOutlet weak var magenticPL: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eletrconL.text = "me the electron mass = 9.1 x 10⁻³¹ kg"
        protonL.text = "m the proton mass = 1.67 x 10⁻²⁷ kg"
        neutronL.text = "m neutron mass = 1.67 x 10⁻²⁷ kg"
        electricPL.text = "permittivity of free space = 8.85 x 10⁻¹²C²/Nm²"
        magenticPL.text = "permeability of free space = 4π x 10⁻⁷TmA⁻¹"
    }
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
