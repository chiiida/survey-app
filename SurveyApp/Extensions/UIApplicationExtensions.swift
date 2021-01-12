//
//  UIApplicationExtensions.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 8/1/2564 BE.
//

import UIKit

extension UIApplication {
    var statusBarView: UIView? {
        if responds(to: Selector(("statusBar"))) {
            return value(forKey: "statusBar") as? UIView
        }
        return nil
    }
}
