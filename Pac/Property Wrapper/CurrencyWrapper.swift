//
//  CurrencyWrapper.swift
//  Pac
//
//  Created by Robert Pacheco on 1/2/20.
//  Copyright © 2020 Robert Pacheco. All rights reserved.
//

import Foundation


/// Wrap string into currency format.
///
/// Example:
///
///     @DiscountWrapper(amount: 0)
///     var discount: String // discount = $0.00
///
@propertyWrapper
struct CurrencyWrapper {
    
    var string: String = ""
    var amount: Cent = 0
    
    var wrappedValue: String {
        get { string }
        set {
            amount = Currency.parseCent(from: newValue)
            string = "\(Currency(amount))"
        }
    }
    
    
    init(amount: Cent = 0) {
        wrappedValue = "\(Currency(amount))"
    }
}
