//
//  VolumeLiquidView.swift
//  UtilityConverter
//
//  Created by Meirunas on 2018-02-24.
//  Copyright © 2018 Meirunas. All rights reserved.
//

import UIKit

class VolumeLiquidView: UIView {
    @IBOutlet var galonTextField: UITextField!
    @IBOutlet var literTextField: UITextField!
    @IBOutlet var pintTextField: UITextField!
    @IBOutlet var fluidOunceTextField: UITextField!
    
    var selectedTextField: UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        galonTextField.delegate = self
        literTextField.delegate = self
        pintTextField.delegate = self
        fluidOunceTextField.delegate = self
    }
    
    func getSavedValue () -> String {
        if galonTextField.text?.count == 0 {
            return ""
        }
        return galonTextField.text! + " galon = " + literTextField.text! + " liter = " + pintTextField.text! + " pint = " + fluidOunceTextField.text! + " fluid ounce "
    }
    
    func formatValue () {
        
        if selectedTextField == galonTextField {
            let value = galonTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    literTextField.text = String(format: "%.4f",result * 3.7854118)
                    pintTextField.text = String(format: "%.4f",result * 8)
                    fluidOunceTextField.text = String(format: "%.4f",result * 128)
                }
            }
            else {
                literTextField.text = ""
                pintTextField.text = ""
                fluidOunceTextField.text = ""
            }
        }
        
        else if selectedTextField == literTextField {
            let value = literTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    galonTextField.text = String(format: "%.4f",result * 0.264172)
                    pintTextField.text = String(format: "%.4f",result * 2.11338)
                    fluidOunceTextField.text = String(format: "%.4f",result * 33.814)
                }
            }
            else {
                galonTextField.text = ""
                pintTextField.text = ""
                fluidOunceTextField.text = ""
            }
        }
        
        else if selectedTextField == pintTextField {
            let value = pintTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    galonTextField.text = String(format: "%.4f",result * 0.125)
                    literTextField.text = String(format: "%.4f",result * 0.473176)
                    fluidOunceTextField.text = String(format: "%.4f",result * 16)
                }
            }
            else {
                galonTextField.text = ""
                literTextField.text = ""
                fluidOunceTextField.text = "";
            }
        }
        else if selectedTextField == fluidOunceTextField {
            let value = fluidOunceTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    galonTextField.text = String(format: "%.4f",result * 0.0062500)
                    literTextField.text = String(format: "%.4f",result / 35.195)
                    pintTextField.text = String(format: "%.4f",result * 0.050000)
                }
            }
            else {
                galonTextField.text = ""
                literTextField.text = ""
                fluidOunceTextField.text = ""
            }
        }
    }
}

extension VolumeLiquidView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.selectedTextField = textField
        return false
    }
}
