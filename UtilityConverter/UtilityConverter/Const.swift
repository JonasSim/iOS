//
//  Const.swift
//  UtilityConverter
//
//  Created by Meirunas on 2018-02-23.
//  Copyright © 2018 Meirunas. All rights reserved.
//

import UIKit

let WEIGHT_VIEW_TAG = 0
let TEMPARATURE_VIEW_TAG = 1
let VOLUME_VIEW_TAG = 2
let VOLUME_LIQUID_VIEW_TAG = 3
let DISTANCE_VIEW_TAG = 4
let SPEED_VIEW_TAG = 5

let WEIGHT_VIEW_KEY = "WEIGHT_VIEW_KEY"
let TEMPARATURE_VIEW_KEY = "TEMPARATURE_VIEW_KEY"
let VOLUME_VIEW_KEY = "VOLUME_VIEW_KEY"
let VOLUME_LIQUID_VIEW_KEY = "VOLUME_LIQUID_VIEW_KEY"
let DISTANCE_VIEW_KEY = "DISTANCE_VIEW_KEY"
let SPEED_VIEW_KEY = "SPEED_VIEW_KEY"


func showAlert(vc:UIViewController, message:String) {
    let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertControllerStyle.alert)
    let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(cancelAction)
    vc.present(alert, animated: true, completion: nil)
}
