//
//  WeightView.swift
//  UtilityConverter
//
//  Created by Meirunas on 2018-02-22.
//  Copyright © 2018 Meirunas. All rights reserved.
//

import UIKit

class WeightView: BaseView {
    
    let KG_TAG = 1
    let GRAMS_TAG = 2
    let OUNCES_TAG = 3
    let POUNDS_TAG = 4
    let STONE_POUNDS_TAG = 5
    
    @IBOutlet var kgTextField: UITextField!
    @IBOutlet var gramTextField: UITextField!
    @IBOutlet var ouncesTextField: UITextField!
    @IBOutlet var poundTextField: UITextField!
    @IBOutlet var stonePoundsTextField: UITextField!
    
    var selectedTextField: UITextField?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        kgTextField.delegate = self
        gramTextField.delegate = self
        ouncesTextField.delegate = self
        poundTextField.delegate = self
        stonePoundsTextField.delegate = self
    }
    
    func getSavedValue () -> String {
        if kgTextField.text?.count == 0 {
            return ""
        }
        return kgTextField.text! + " kg = " + gramTextField.text! + " gram = " + ouncesTextField.text! + " ounces = " + poundTextField.text! + " pounds = " + stonePoundsTextField.text! + " stone"
     }
    
    func formatValue () {
        
        /* kg */
        if selectedTextField == kgTextField {
            let value = kgTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    gramTextField.text = String(format: "%.4f",result * 1000.0000)
                    ouncesTextField.text = String(format: "%.4f",result * 35.27396195)
                    poundTextField.text = String(format: "%.4f",result * 2.2046226218)
                    stonePoundsTextField.text = String(format: "%.4f",result * 0.157473)
                }
            }
            else {
                gramTextField.text = ""
                ouncesTextField.text = ""
                poundTextField.text = ""
                stonePoundsTextField.text = ""
            }
        }
        
        /* gram */
        else if selectedTextField == gramTextField {
            let value = gramTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    kgTextField.text = String(format: "%.4f",result * 0.001)
                    ouncesTextField.text = String(format: "%.4f",result * 0.035274)
                    poundTextField.text = String(format: "%.4f",result * 0.00220462)
                    stonePoundsTextField.text = String(format: "%.4f",result * 0.000157473)
                }
            }
            else {
                kgTextField.text = ""
                ouncesTextField.text = ""
                poundTextField.text = ""
                stonePoundsTextField.text = ""
            }
        }
        
        /* ounces */
        else if selectedTextField == ouncesTextField {
            let value = ouncesTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    kgTextField.text = String(format: "%.4f",result * 0.0283495)
                    gramTextField.text = String(format: "%.4f",result * 28.3495)
                    poundTextField.text = String(format: "%.4f",result * 0.0625)
                    stonePoundsTextField.text = String(format: "%.4f",result * 0.00446429)
                }
            }
            else {
                kgTextField.text = ""
                gramTextField.text = ""
                poundTextField.text = ""
                stonePoundsTextField.text = ""
            }
        }
        
        /* pound */
        else if selectedTextField == poundTextField {
            let value = poundTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    kgTextField.text = String(format: "%.4f",result * 0.453592)
                    gramTextField.text = String(format: "%.4f",result * 453.592)
                    ouncesTextField.text = String(format: "%.4f",result * 16)
                    stonePoundsTextField.text = String(format: "%.4f",result * 0.0714286)
                }
            }
            else {
                kgTextField.text = ""
                gramTextField.text = ""
                ouncesTextField.text = ""
                stonePoundsTextField.text = ""
            }
        }
        
        /* stone */
        else if selectedTextField == stonePoundsTextField {
            let value = stonePoundsTextField.text!
            if value.count > 0 {
                if let result = Float(value) {
                    kgTextField.text = String(format: "%.4f",result * 6.35029)
                    gramTextField.text = String(format: "%.4f",result * 6350.29)
                    ouncesTextField.text = String(format: "%.4f",result * 224)
                    poundTextField.text = String(format: "%.4f",result * 14)
                }
            }
            else {
                kgTextField.text = ""
                gramTextField.text = ""
                ouncesTextField.text = ""
                poundTextField.text = ""
            }
        }
    }
    
}

extension WeightView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.selectedTextField = textField
        return false
    }
    
}
