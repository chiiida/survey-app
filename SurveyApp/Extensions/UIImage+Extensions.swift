//
//  UIImage+Extensions.swift
//  SurveyApp
//
//  Created by Chananchida Fuachai on 9/1/2564 BE.
//

import UIKit

extension UIImage {

    convenience init?(withContentsOfUrl url: URL) throws {
        let imageData = try Data(contentsOf: url)
    
        self.init(data: imageData)
    }

}
