//
//  ViewController.swift
//  UtilityConverter
//
//  Created by Meirunas on 2018-02-22.
//  Copyright © 2018 Meirunas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet var keyboardView: UIView!
    @IBOutlet var mainView: UIView!
    
    var selectedViewTag = WEIGHT_VIEW_TAG
    
    let weightView: WeightView = UIView.fromNib()
    let temperatureView: TemperatureView = UIView.fromNib()
    let distanceView: DistanceView = UIView.fromNib()
    let volumeLiquidView: VolumeLiquidView = UIView.fromNib()
    let volumeView: VolumeView = UIView.fromNib()
    let speedView: SpeedView = UIView.fromNib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        selectedViewTag = WEIGHT_VIEW_TAG
        selectButtonWithTag(tag: selectedViewTag)
        
        
        weightView.frame = CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: mainView.frame.size.height)
        mainView.addSubview(weightView)
        
        temperatureView.frame = CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: mainView.frame.size.height)
        mainView.addSubview(temperatureView)
        
        distanceView.frame = CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: mainView.frame.size.height)
        mainView.addSubview(distanceView)
        
        volumeLiquidView.frame = CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: mainView.frame.size.height)
        mainView.addSubview(volumeLiquidView)
        
        volumeView.frame = CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: mainView.frame.size.height)
        mainView.addSubview(volumeView)
        
        speedView.frame = CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: mainView.frame.size.height)
        mainView.addSubview(speedView)
        
        mainView.bringSubview(toFront: weightView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectButtonWithTag(tag:Int) {
        for button in buttonCollection {
            if button.tag == tag {
                button.isSelected = true
            }
            else {
                button.isSelected = false
            }
        }
    }


    // ACTIONS
    
    // top
    @IBAction func weightButtonClicked(_ sender: Any) {
        selectedViewTag = WEIGHT_VIEW_TAG
        selectButtonWithTag(tag: selectedViewTag)
        mainView.bringSubview(toFront: weightView)
    }
    
    @IBAction func temparatureButtonClicked(_ sender: Any) {
        selectedViewTag = TEMPARATURE_VIEW_TAG
        selectButtonWithTag(tag: selectedViewTag)
        mainView.bringSubview(toFront: temperatureView)
    }
    
    @IBAction func volumeButtonClicked(_ sender: Any) {
        selectedViewTag = VOLUME_VIEW_TAG
        selectButtonWithTag(tag: selectedViewTag)
        mainView.bringSubview(toFront: volumeView)
    }
    
    @IBAction func volumeLiquidButtonClicked(_ sender: Any) {
        selectedViewTag = VOLUME_LIQUID_VIEW_TAG
        selectButtonWithTag(tag: selectedViewTag)
        mainView.bringSubview(toFront: volumeLiquidView)
    }
    
    @IBAction func distanceButtonClicked(_ sender: Any) {
        selectedViewTag = DISTANCE_VIEW_TAG
        selectButtonWithTag(tag: selectedViewTag)
        mainView.bringSubview(toFront: distanceView)
    }
    
    @IBAction func speedButtonClicked(_ sender: Any) {
        selectedViewTag = SPEED_VIEW_TAG
        selectButtonWithTag(tag: selectedViewTag)
        mainView.bringSubview(toFront: speedView)
    }
    
    
    // Bottom
    @IBAction func physicalConstantButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "PhysicalConstantsViewController") as! PhysicalConstantsViewController
        self.present(controller, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        let defaults = UserDefaults.standard
        var showErrorMsg: Bool = false
        var value = ""
        var key = ""
        if selectedViewTag == WEIGHT_VIEW_TAG {
            value = weightView.getSavedValue()
            key = WEIGHT_VIEW_KEY
        }
        else if selectedViewTag == TEMPARATURE_VIEW_TAG {
            value = temperatureView.getSavedValue()
            key = TEMPARATURE_VIEW_KEY
        }
        else if selectedViewTag == VOLUME_VIEW_TAG {
            value = volumeView.getSavedValue()
            key = VOLUME_VIEW_KEY
        }
        else if selectedViewTag == VOLUME_LIQUID_VIEW_TAG {
            value = volumeLiquidView.getSavedValue()
            key = VOLUME_LIQUID_VIEW_KEY
        }
        else if selectedViewTag == DISTANCE_VIEW_TAG {
            value = distanceView.getSavedValue()
            key = DISTANCE_VIEW_KEY
        }
        else if selectedViewTag == SPEED_VIEW_TAG {
            value = speedView.getSavedValue()
            key = SPEED_VIEW_KEY
        }
        
        if value == "" {
            showErrorMsg = true
        }
        else {
            var myarray = defaults.stringArray(forKey: key) ?? [String]()
            myarray.insert(value, at: 0)
            defaults.set(myarray, forKey: key)
            defaults.synchronize()
            showAlert(vc: self, message: "Successfully saved.")
        }
        
        if showErrorMsg == true {
            showAlert(vc: self, message: "Cannot save empty value")
        }
    }
    
    @IBAction func historyButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        controller.selectedViewTag = selectedViewTag
        self.present(controller, animated: true, completion: nil)
    }
    
    //keyboard
    @IBAction func oneClicked(_ sender: Any) {
        if checkIfTextFieldIsFocus() {
            increaseValue(value: "1")
        }
    }
    
    @IBAction func twoClicked(_ sender: Any) {
        if checkIfTextFieldIsFocus() {
            increaseValue(value: "2")
        }
    }
    
    @IBAction func threeClicked(_ sender: Any) {
        if checkIfTextFieldIsFocus() {
            increaseValue(value: "3")
        }
    }
    
    @IBAction func fourthClicked(_ sender: Any) {
        if checkIfTextFieldIsFocus() {
            increaseValue(value: "4")
        }
    }
    
    @IBAction func fiveClicked(_ sender: Any) {
        if checkIfTextFieldIsFocus() {
            increaseValue(value: "5")
        }
    }
    
    @IBAction func sixClicked(_ sender: Any) {
        if checkIfTextFieldIsFocus() {
            increaseValue(value: "6")
        }
    }
    @IBAction func sevenClicked(_ sender: Any) {
        if checkIfTextFieldIsFocus() {
            increaseValue(value: "7")
        }
    }
    @IBAction func eightClicked(_ sender: Any) {
        if checkIfTextFieldIsFocus() {
            increaseValue(value: "8")
        }
    }
    @IBAction func nineClicked(_ sender: Any) {
        if checkIfTextFieldIsFocus() {
            increaseValue(value: "9")
        }
    }
    @IBAction func zeroClicked(_ sender: Any) {
        if checkIfTextFieldIsFocus() {
            increaseValue(value: "0")
        }
    }
    @IBAction func deleteClicked(_ sender: Any) {
        var text = ""
        
        if selectedViewTag == WEIGHT_VIEW_TAG {
            text = (weightView.selectedTextField?.text!)!
        }
        else if selectedViewTag == TEMPARATURE_VIEW_TAG {
            text = (temperatureView.selectedTextField?.text!)!
        }
        else if selectedViewTag == VOLUME_VIEW_TAG {
            text = (volumeView.selectedTextField?.text!)!
        }
        else if selectedViewTag == VOLUME_LIQUID_VIEW_TAG {
            text = (volumeLiquidView.selectedTextField?.text!)!
        }
        else if selectedViewTag == DISTANCE_VIEW_TAG {
            text = (distanceView.selectedTextField?.text!)!
        }
        else if selectedViewTag == SPEED_VIEW_TAG {
            text = (speedView.selectedTextField?.text!)!
        }
            
        
        if text.count > 0 {
            let truncated = text.substring(to: text.index(before: text.endIndex))
            
            if selectedViewTag == WEIGHT_VIEW_TAG {
                weightView.selectedTextField?.text = truncated
                weightView.formatValue()
            }
            else if selectedViewTag == TEMPARATURE_VIEW_TAG {
                temperatureView.selectedTextField?.text = truncated
                temperatureView.formatValue()
            }
            else if selectedViewTag == VOLUME_VIEW_TAG {
                volumeView.selectedTextField?.text = truncated
                volumeView.formatValue()
            }
            else if selectedViewTag == VOLUME_LIQUID_VIEW_TAG {
                volumeLiquidView.selectedTextField?.text = truncated
                volumeLiquidView.formatValue()
            }
            else if selectedViewTag == DISTANCE_VIEW_TAG {
                distanceView.selectedTextField?.text = truncated
                distanceView.formatValue()
            }
            else if selectedViewTag == SPEED_VIEW_TAG {
                speedView.selectedTextField?.text = truncated
                speedView.formatValue()
            }
        }
    }
    @IBAction func negClicked(_ sender: Any) {
        increaseValue(value: "-")
    }
    
    @IBAction func dotClicked(_ sender: Any) {
        increaseValue(value: ".")
    }
    
    // private function
    
    private func checkIfTextFieldIsFocus() -> Bool{
        
        if (selectedViewTag == WEIGHT_VIEW_TAG && weightView.selectedTextField == nil) ||
            (selectedViewTag == TEMPARATURE_VIEW_TAG && temperatureView.selectedTextField == nil) ||
            (selectedViewTag == VOLUME_VIEW_TAG && volumeView.selectedTextField == nil) ||
            (selectedViewTag == VOLUME_LIQUID_VIEW_TAG && volumeLiquidView.selectedTextField == nil) ||
            (selectedViewTag == DISTANCE_VIEW_TAG && distanceView.selectedTextField == nil) ||
            (selectedViewTag == SPEED_VIEW_TAG && speedView.selectedTextField == nil)
        {
            
            showAlert(vc: self, message: "Please select a textfield.")
            return false
        }
        return true
    }
    
    private func increaseValue(value:String) {
        
        // WEIGHT VIEW
        
        if selectedViewTag == WEIGHT_VIEW_TAG {
            let text = weightView.selectedTextField?.text!
            if text?.count == 0 && value == "0" {
                // do nothing
            }
            else if text?.range(of: ".") != nil && value == "." {
                // do nothing
            }
            else {
                weightView.selectedTextField?.text = text! + value
                weightView.formatValue()
            }
        }
        
        // TEMPARATURE VIEW
        
        else if selectedViewTag == TEMPARATURE_VIEW_TAG {
            let text = temperatureView.selectedTextField?.text!
            if text?.count == 0 && value == "0" {
                // do nothing
            }
            else if text?.range(of: ".") != nil && value == "." {
                // do nothing
            }
            else {
                temperatureView.selectedTextField?.text = text! + value
                temperatureView.formatValue()
            }
        }
            
            
        // VOLUME VIEW
            
        else if selectedViewTag == VOLUME_VIEW_TAG {
            let text = volumeView.selectedTextField?.text!
            if text?.count == 0 && value == "0" {
                // do nothing
            }
            else if text?.range(of: ".") != nil && value == "." {
                // do nothing
            }
            else {
                volumeView.selectedTextField?.text = text! + value
                volumeView.formatValue()
            }
        }
            
            
        // VOLUME LIQUID VIEW
            
        else if selectedViewTag == VOLUME_LIQUID_VIEW_TAG {
            let text = volumeLiquidView.selectedTextField?.text!
            if text?.count == 0 && value == "0" {
                // do nothing
            }
            else if text?.range(of: ".") != nil && value == "." {
                // do nothing
            }
            else {
                volumeLiquidView.selectedTextField?.text = text! + value
                volumeLiquidView.formatValue()
            }
        }
        
        // DISTANCE VIEW
            
        else if selectedViewTag == DISTANCE_VIEW_TAG {
            let text = distanceView.selectedTextField?.text!
            if text?.count == 0 && value == "0" {
                // do nothing
            }
            else if text?.range(of: ".") != nil && value == "." {
                // do nothing
            }
            else {
                distanceView.selectedTextField?.text = text! + value
                distanceView.formatValue()
            }
        }
        
        // SPEED VIEW
            
        else if selectedViewTag == SPEED_VIEW_TAG {
            let text = speedView.selectedTextField?.text!
            if text?.count == 0 && value == "0" {
                // do nothing
            }
            else if text?.range(of: ".") != nil && value == "." {
                // do nothing
            }
            else {
                speedView.selectedTextField?.text = text! + value
                speedView.formatValue()
            }
        }
    }
    
}

