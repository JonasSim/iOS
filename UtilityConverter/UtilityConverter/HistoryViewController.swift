//
//  HistoryViewController.swift
//  UtilityConverter
//
//  Created by Meirunas on 2018-02-23.
//  Copyright © 2018 Meirunas. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var selectedViewTag : Int = WEIGHT_VIEW_TAG
    
    @IBOutlet var labelCollection: [UILabel]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if selectedViewTag == WEIGHT_VIEW_TAG {
            setValueWithKey(key: WEIGHT_VIEW_KEY)
        }
        else if selectedViewTag == TEMPARATURE_VIEW_TAG {
            setValueWithKey(key: TEMPARATURE_VIEW_KEY)
        }
    }
    
    func setValueWithKey(key:String) {
        for label in labelCollection {
            label.text = ""
        }
        let defaults = UserDefaults.standard
        let myarray = defaults.stringArray(forKey: key) ?? [String]()
        for (index, item) in myarray.enumerated() {
            if index > 4 {
                return 
            }
            labelCollection[index].text = item
        }
    }
    
    @IBAction func weightButtonClicked(_ sender: Any) {
        setValueWithKey(key: WEIGHT_VIEW_KEY)
    }
    
    @IBAction func temparatureButtonClicked(_ sender: Any) {
        setValueWithKey(key: TEMPARATURE_VIEW_KEY)
    }
    
    @IBAction func volumeButtonClicked(_ sender: Any) {
        setValueWithKey(key: VOLUME_VIEW_KEY)
    }
    
    @IBAction func volumeLiquidButtonClicked(_ sender: Any) {
        setValueWithKey(key: VOLUME_LIQUID_VIEW_KEY)
    }
    
    @IBAction func distanceButtonClicked(_ sender: Any) {
        setValueWithKey(key: DISTANCE_VIEW_KEY)
    }
    
    @IBAction func speedButtonClicked(_ sender: Any) {
        setValueWithKey(key: SPEED_VIEW_KEY)
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
