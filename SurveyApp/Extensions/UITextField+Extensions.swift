//
//  UITextField+Extensions.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 6/1/2564 BE.
//
import UIKit

extension UITextField {
    
    func addHorizontalPadding(withValue padding: CGFloat) {
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        leftViewMode = .always
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.height))
        rightViewMode = .always
    }
}
