//
//  UIImage+Extensions.swift
//  Pac
//
//  Created by Robert Pacheco on 12/18/19.
//  Copyright © 2019 Robert Pacheco. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

extension UIImage {
    
    var toJpegCompressedData: Data? {
        return jpegData(compressionQuality: 0.4)
    }
    var placeholderImage: UIImage {
        return UIImage(systemName: "person.crop.rectangle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 100, weight: .regular))!
    }
    var vehicleImage: UIImage {
        return UIImage(systemName: "car", withConfiguration: UIImage.SymbolConfiguration(pointSize: 100, weight: .heavy))!
    }
   
}


