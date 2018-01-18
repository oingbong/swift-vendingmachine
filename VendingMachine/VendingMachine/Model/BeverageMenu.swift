//
//  Menu.swift
//  VendingMachine
//
//  Created by yuaming on 2018. 1. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum BeverageMenu {
    case bananaMilk
    case cocaCola
    case georgia
    case pepsi
    case strawberryMilk
    case top
    
    static var allValues: [BeverageMenu] {
        return [.bananaMilk, .cocaCola, .georgia, .pepsi, .strawberryMilk, .top]
    }
    
    func makeInstance() -> Beverage {
        let today = DateUtility.today()
        switch self {
        case .bananaMilk:
            return BananaMilk(brand: "빙그레", volume: 250, price: 1500, productName: "바나나우유", expiryDate: today, calorie: 300)
        case .cocaCola:
            return CocaCola(brand: "코카콜라", volume: 500, price: 1430, productName: "코카콜라", expiryDate: today, calorie: 250)
        case .georgia:
            return Georgia(brand: "코카콜라", volume: 240, price: 1100, productName: "조지아 오리지널", expiryDate: today, calorie: 94)
        case .pepsi:
            return Pepsi(brand: "펩시콜라", volume: 355, price: 1200, productName: "펩시", expiryDate: today, calorie: 275)
        case .strawberryMilk:
            return StrawberryMilk(brand: "빙그레", volume: 355, price: 1200, productName: "딸기우유", expiryDate: today, calorie: 275)
        case .top:
            return TOP(brand: "맥심", volume: 275, price: 1800, productName: "TOP 스위트아메리카노", expiryDate: today, calorie: 48)
        }
    }
}