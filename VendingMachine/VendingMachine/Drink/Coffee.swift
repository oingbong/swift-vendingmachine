//
//  Coffee.swift
//  VendingMachine
//
//  Created by yangpc on 2017. 11. 13..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

class Coffee: Drink {
    private(set) var isHot: Bool
    private(set) var amountOfCaffeine: Int
    private(set) var nameOfCoffeeBeans: String
    // 제조일로부터 12개월
    override var expirationDate: Date? {
        guard let manufacturingDate = dateFormatter.date(from: self.dateOfManufacture) else {
            return nil
        }
        return Date(timeInterval: 3600 * 24 * 365 * 12, since: manufacturingDate)
    }

    init?(productTpye: String,
          calorie: String,
          brand: String,
          weight: String,
          price: String,
          name: String,
          dateOfManufacture: String,
          isHot: Bool,
          amountOfCaffeine: String,
          nameOfCoffeeBeans: String) {
        self.isHot = isHot
        guard let amountOfCaffeine = amountOfCaffeine.convert(to: "mg") else { return nil }
        self.amountOfCaffeine = amountOfCaffeine
        self.nameOfCoffeeBeans = nameOfCoffeeBeans
        super.init(productTpye: productTpye,
                   calorie: calorie,
                   brand: brand,
                   weight: weight,
                   price: price,
                   name: name,
                   dateOfManufacture: dateOfManufacture)
    }
    
    func isSuitableAmountOfCaffeine(to age: Int) -> Bool {
        if age > 19 && self.amountOfCaffeine == 400 {
            return true
        }
        if age <= 19 && self.amountOfCaffeine == 125 {
            return true
        }
        return false
    }
    
    func isLowCalorie() -> Bool {
        return self.calorie <= 30 ? true : false
    }

}