//
//  TemperatureView.swift
//  UtilityConverter
//
//  Created by Meirunas on 2018-02-23.
//  Copyright © 2018 Meirunas. All rights reserved.
//

import UIKit

class TemperatureView: BaseView {
    
    @IBOutlet var celciusTextField: UITextField!
    @IBOutlet var fahrenheitTextField: UITextField!
    @IBOutlet var kelvinTextField: UITextField!
    
    var selectedTextField: UITextField?
    
    override func awakeFromNib() {
        super .awakeFromNib()
        celciusTextField.delegate = self
        fahrenheitTextField.delegate = self
        kelvinTextField.delegate = self
    }
    
    func getSavedValue () -> String {
        if celciusTextField.text?.count == 0 {
            return ""
        }
        return celciusTextField.text! + " Celcius = " + fahrenheitTextField.text! + " Fahrenheit = " + kelvinTextField.text! + " Kelvin"
    }
    
    func formatValue () {
        
        if selectedTextField == celciusTextField {
            let value = celciusTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    fahrenheitTextField.text = String(format: "%.4f",result * 1.8 + 32)
                    kelvinTextField.text = String(format: "%.4f",result + 273.15)
                }
            }
            else {
                fahrenheitTextField.text = ""
                kelvinTextField.text = ""
            }
        }
        
        
        else if selectedTextField == fahrenheitTextField {
            let value = fahrenheitTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    celciusTextField.text = String(format: "%.4f",(result - 32) * 5/9 )
                    kelvinTextField.text = String(format: "%.4f",(result + 459.67) * 5/9)
                }
            }
            else {
                celciusTextField.text = ""
                kelvinTextField.text = ""
            }
        }
        
        else if selectedTextField == kelvinTextField {
            let value = kelvinTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    celciusTextField.text = String(format: "%.4f",result - 273.15 )
                    fahrenheitTextField.text = String(format: "%.4f",9/5 * (result - 273.15) + 32)
                }
            }
            else {
                celciusTextField.text = ""
                fahrenheitTextField.text = ""
            }
        }
    }
}

extension TemperatureView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.selectedTextField = textField
        return false
    }
}
