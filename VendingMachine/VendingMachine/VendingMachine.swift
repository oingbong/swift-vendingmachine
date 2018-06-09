//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by moon on 2018. 6. 9..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct VendingMachine {
    
    var insertedMoney: Int = 0
    var beverageStock: BeverageList = BeverageList()
    
    var isStockEmpty: Bool {
        return self.beverageStock.isEmpty
    }
    
    mutating func insertMoney(_ money: Int) {
        self.insertedMoney += money
    }
    
    mutating func addBeverageStock(_ beverage: Beverage) {
        self.beverageStock.addBeverage(beverage)
    }
    
    func showPurchasableBeverages() -> String {
        return ""
    }
}

struct BeverageList {
    
    private var beverageList: [Beverage] = [Beverage]()
    
    var isEmpty: Bool {
        return beverageList.count == 0
    }
    
    mutating func addBeverage(_ beverage: Beverage) {
        self.beverageList.append(beverage)
    }
}
