//
//  DistanceView.swift
//  UtilityConverter
//
//  Created by Meirunas on 2018-02-23.
//  Copyright © 2018 Meirunas. All rights reserved.
//

import UIKit

class DistanceView : BaseView {
    @IBOutlet var cmTextField: UITextField!
    @IBOutlet var meterTextField: UITextField!
    @IBOutlet var inchTextField: UITextField!
    @IBOutlet var mmTextField: UITextField!
    @IBOutlet var yardTextField: UITextField!
    
    var selectedTextField: UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cmTextField.delegate = self
        meterTextField.delegate = self
        inchTextField.delegate = self
        mmTextField.delegate = self
        yardTextField.delegate = self
    }
    
    func getSavedValue () -> String {
        if cmTextField.text?.count == 0 {
            return ""
        }
        return cmTextField.text! + " cm = " + meterTextField.text! + " meter = " + inchTextField.text! + " inch = " + mmTextField.text! + " mm = " + yardTextField.text! + " yard"
    }
    
    func formatValue () {
        if selectedTextField == cmTextField {
            let value = cmTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    meterTextField.text = String(format: "%.4f",result * 0.01)
                    inchTextField.text = String(format: "%.4f",result * 0.39)
                    mmTextField.text = String(format: "%.4f",result * 0.1)
                    yardTextField.text = String(format: "%.4f",result / 91.44)
                }
            }
            else {
                meterTextField.text = ""
                inchTextField.text = ""
                mmTextField.text = ""
                yardTextField.text = ""
            }
        }
        
        
        else if selectedTextField == meterTextField {
            let value = meterTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    cmTextField.text = String(format: "%.4f",result * 100)
                    inchTextField.text = String(format: "%.4f",result / 0.0254)
                    mmTextField.text = String(format: "%.4f",result * 1000)
                    yardTextField.text = String(format: "%.4f",result * 1.0936)
                }
            }
            else {
                cmTextField.text = ""
                inchTextField.text = ""
                mmTextField.text = ""
                yardTextField.text = ""
            }
        }
        
        
        else if selectedTextField == inchTextField {
            let value = inchTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    cmTextField.text = String(format: "%.4f",result * 2.54)
                    meterTextField.text = String(format: "%.4f",result * 0.0254)
                    mmTextField.text = String(format: "%.4f",result * 25.4)
                    yardTextField.text = String(format: "%.4f",result * 0.027778)
                }
            }
            else {
                cmTextField.text = ""
                meterTextField.text = ""
                mmTextField.text = ""
                yardTextField.text = ""
            }
        }
        
        else if selectedTextField == mmTextField {
            let value = mmTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    cmTextField.text = String(format: "%.4f",result / 10.000)
                    meterTextField.text = String(format: "%.4f",result / 1000.0)
                    inchTextField.text = String(format: "%.4f",result * 0.039370)
                    yardTextField.text = String(format: "%.4f",result * 0.0010936)
                    
                }
            }
            else {
                cmTextField.text = ""
                meterTextField.text = ""
                yardTextField.text = ""
                inchTextField.text = ""
            }
        }
        
        else if selectedTextField == yardTextField {
            let value = yardTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    cmTextField.text = String(format: "%.4f",result * 91.44)
                    meterTextField.text = String(format: "%.4f",result * 0.9144)
                    inchTextField.text = String(format: "%.4f",result * 36)
                    mmTextField.text = String(format: "%.4f",result * 914.4)
                    
                }
            }
            else {
                cmTextField.text = ""
                meterTextField.text = ""
                mmTextField.text = ""
                inchTextField.text = ""
            }
        }
    }
}

extension DistanceView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.selectedTextField = textField
        return false
    }
}

