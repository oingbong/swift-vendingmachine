//
//  Coffee.swift
//  VendingMachine
//
//  Created by oingbong on 2018. 9. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Coffee: Beverage {
    private var caffeine: Int // 카페인함량 (mg)
    
    init(caffeine: Int, brand:String, capacity:Int, price:Int, name:String, dateOfManufacture:Date, manufacturer:String) {
        self.caffeine = caffeine
        super.init(brand: brand, capacity: capacity, price: price, name: name, dateOfManufacture: dateOfManufacture, manufacturer: manufacturer)
    }
    
    public func isNoneCaffeine() -> Bool {
        return self.caffeine == 0 ? true : false
    }
}

class TOP: Coffee {
    private var hot: Bool // 뜨거움 여부
    
    init(dateOfManufacture : Date) {
        self.hot = true
        super.init(caffeine: 120, brand: Brand.maxim.description, capacity: 275, price: 1800, name: Product.topCoffee.description, dateOfManufacture: dateOfManufacture, manufacturer: Brand.maxim.description)
    }
    
    init(hot: Bool, caffeine: Int, brand:String, capacity:Int, price:Int, name:String, dateOfManufacture:Date, manufacturer:String) {
        self.hot = hot
        super.init(caffeine: caffeine, brand: brand, capacity: capacity, price: price, name: name, dateOfManufacture: dateOfManufacture, manufacturer: manufacturer)
    }
    
    public func isHot() -> Bool {
        return self.hot
    }
}

class Cantata: Coffee {
    private var sugarFree: Bool // 무가당여부
    
    init(dateOfManufacture : Date) {
        self.sugarFree = true
        super.init(caffeine: 100, brand: Brand.lotteChilsung.description, capacity: 275, price: 1400, name: Product.cantataCoffee.description, dateOfManufacture: dateOfManufacture, manufacturer: Brand.lotteChilsung.description)
    }
    
    init(sugarFree: Bool, caffeine: Int, brand:String, capacity:Int, price:Int, name:String, dateOfManufacture:Date, manufacturer:String) {
        self.sugarFree = sugarFree
        super.init(caffeine: caffeine, brand: brand, capacity: capacity, price: price, name: name, dateOfManufacture: dateOfManufacture, manufacturer: manufacturer)
    }
    
    public func isSugarFree() -> Bool {
        return self.sugarFree
    }
}

class Georgia: Coffee {
    private var packageMaterial: Material // 패키지재질 ( Can , Plastic , Glass , etc..)
    
    init(dateOfManufacture : Date) {
        self.packageMaterial = Material.can
        super.init(caffeine: 80, brand: Brand.cocacola.description, capacity: 240, price: 1800, name: Product.georgiaCoffee.description, dateOfManufacture: dateOfManufacture, manufacturer: Brand.cocacola.description)
    }
    
    init(packageMaterial: Material, caffeine: Int, brand:String, capacity:Int, price:Int, name:String, dateOfManufacture:Date, manufacturer:String) {
        self.packageMaterial = packageMaterial
        super.init(caffeine: caffeine, brand: brand, capacity: capacity, price: price, name: name, dateOfManufacture: dateOfManufacture, manufacturer: manufacturer)
    }
    
    public func isCan() -> Bool {
        return self.packageMaterial == Material.can ? true : false
    }
}
