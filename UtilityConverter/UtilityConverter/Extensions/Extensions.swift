//
//  Extensions.swift
//  UtilityConverter
//
//  Created by Hoang on 2018-02-22.
//  Copyright © 2018 Hoang. All rights reserved.
//

import UIKit

extension UIView {
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
