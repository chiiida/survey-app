//
//  UIImageView+Extensions.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 7/1/2564 BE.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    func loadUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
    
    func circle() {
        layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
}
