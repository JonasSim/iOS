//
//  SpeedView.swift
//  UtilityConverter
//
//  Created by Meirunas on 2018-02-24.
//  Copyright © 2018 Meirunas. All rights reserved.
//

import UIKit

class SpeedView: UIView {

    var selectedTextField: UITextField?
    
    @IBOutlet var meterTextField: UITextField!
    @IBOutlet var kmTextField: UITextField!
    @IBOutlet var milesTextField: UITextField!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        meterTextField.delegate = self
        kmTextField.delegate = self
        milesTextField.delegate = self
    }
    
    func getSavedValue () -> String {
        if meterTextField.text?.count == 0 {
            return ""
        }
        return meterTextField.text! + " meter = " + kmTextField.text! + " km = " + milesTextField.text! + " miles = "
    }
    
    func formatValue () {
        
        if selectedTextField == meterTextField {
            let value = meterTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    kmTextField.text = String(format: "%.4f",result * 3.6)
                    milesTextField.text = String(format: "%.4f",result * 2.23694)
                }
            }
            else {
                kmTextField.text = ""
                milesTextField.text = ""
            }
        }
        
        else if selectedTextField == kmTextField {
            let value = kmTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    meterTextField.text = String(format: "%.4f",result * 0.277778)
                    milesTextField.text = String(format: "%.4f",result * 0.621371)
                }
            }
            else {
                meterTextField.text = ""
                milesTextField.text = ""
            }
        }
        
        
        else if selectedTextField == milesTextField {
            let value = milesTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    meterTextField.text = String(format: "%.4f",result * 0.44704)
                    kmTextField.text = String(format: "%.4f",result * 1.60934)
                }
            }
            else {
                meterTextField.text = ""
                kmTextField.text = ""
            }
        }
    }
}

extension SpeedView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.selectedTextField = textField
        return false
    }
    
}
