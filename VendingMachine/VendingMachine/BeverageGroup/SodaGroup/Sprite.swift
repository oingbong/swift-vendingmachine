//
//  Sprite.swift
//  VendingMachine
//
//  Created by Eunjin Kim on 2018. 1. 11..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Sprite: Soda {
    private var kindOfSoda: String = "사이다"
    private var flavoringSyrups: String = "레몬라임향"
    init(brand: String, weight: Int, price: Int, name: String, manufactureDate: Date, flavoringSyrups: String) {
        self.flavoringSyrups = flavoringSyrups
        super.init(brand: brand, weight: weight, price: price, name: name, manufactureDate: manufactureDate)
    }
    override var description: String {
        return "\(self.kindOfSoda)(Sprite)\(super.description)"
    }
    
    func isLemonLimeFlavor() -> Bool {
        return (self.flavoringSyrups == "레몬라임향")
    }
}
