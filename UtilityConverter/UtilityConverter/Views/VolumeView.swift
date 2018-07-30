//
//  VolumeView.swift
//  UtilityConverter
//
//  Created by Meirunas on 2018-02-24.
//  Copyright © 2018 Meirunas. All rights reserved.
//

import UIKit

class VolumeView: UIView {
    @IBOutlet var m3TextField: UITextField!
    @IBOutlet var cm3TextField: UITextField!
    @IBOutlet var litreTextField: UITextField!
    
    var selectedTextField: UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        m3TextField.delegate = self
        cm3TextField.delegate = self
        litreTextField.delegate = self
    }
    
    func getSavedValue () -> String {
        if m3TextField.text?.count == 0 {
            return ""
        }
        return m3TextField.text! + " m3 = " + cm3TextField.text! + " cm3 = " + litreTextField.text! + " liter"
        
    }
    
    func formatValue () {
        
        if selectedTextField == m3TextField {
            let value = m3TextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    cm3TextField.text = String(format: "%.4f",result * 1000000)
                    litreTextField.text = String(format: "%.4f",result * 1000)
                }
            }
            else {
                cm3TextField.text = ""
                litreTextField.text = ""
            }
        }
        
        else if selectedTextField == cm3TextField {
            let value = cm3TextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    m3TextField.text = String(format: "%.4f",result / 1000000)
                    litreTextField.text = String(format: "%.4f",result * 0.001)
                }
            }
            else {
                m3TextField.text = ""
                litreTextField.text = ""
            }
        }
        
        else if selectedTextField == litreTextField {
            let value = litreTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    m3TextField.text = String(format: "%.4f",result * 0.001)
                    cm3TextField.text = String(format: "%.4f",result * 1000)
                }
            }
            else {
                m3TextField.text = ""
                cm3TextField.text = ""
            }
        }
        
    }
}
extension VolumeView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.selectedTextField = textField
        return false
    }
}
