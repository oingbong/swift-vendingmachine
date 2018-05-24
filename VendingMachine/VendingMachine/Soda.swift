//
//  Soda.swift
//  VendingMachine
//
//  Created by 김수현 on 2018. 5. 23..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Soda: Beverage {
    
    private let kind: Kind
    
    init(_ kind: Kind,_ brand: String, _ volume: Int, _ price: Int, _ name: String, _ date: Date) {
        self.kind = kind
        super.init(brand, volume, price, name, date)
    }
    
}

extension Soda {
    
    enum Kind: CustomStringConvertible {
        case coke, sprite, fanta
        
        var description: String {
            switch self {
            case .coke: return "콜라"
            case .sprite: return "사이다"
            case .fanta: return "환타"
            }
        }
    }
}
