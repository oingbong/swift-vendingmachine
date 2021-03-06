//
//  Product.swift
//  VendingMachine
//
//  Created by oingbong on 2018. 9. 18..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Beverage : NSObject {
    
    private var brand: String
    private var capacity: Int
    private var price: Int
    private var name: String
    private var dateOfManufacture: Date
    private var manufacturer: String
    
    init(brand:String, capacity:Int, price:Int, name:String, dateOfManufacture:Date, manufacturer:String) {
        self.brand = brand
        self.capacity = capacity
        self.price = price
        self.name = name
        self.dateOfManufacture = dateOfManufacture
        self.manufacturer = manufacturer
    }
    
    override var description: String {
        return "\(self.name) \(self.price)원"
    }
    
    // 클래스명 출력
    override var className: String {
        return String(describing: type(of: self))
    }
    
    private func convertDate(_ time: Double) -> Double {
        return Double(time / Double(DateUnit.secondsOfOneday))
    }
    
    // 유통기한은 모든 제품 14일 기준
    public func isExpirationDate(with date:Date) -> Bool {
        let betweenDate = convertDate(date.timeIntervalSince(self.dateOfManufacture))
        return betweenDate >= 14 ? true : false
    }
    
    // 대용량 음료 확인
    public func isLargeCapacity() -> Bool {
        return self.capacity >= 300 ? true : false
    }
    
    // 현재 잔액으로 구매 가능한지 확인
    public func isAvailablePurchase(with balance:Int) -> Bool {
        return balance >= self.price ? true : false
    }
    
    public func beveragePrice() -> Int {
        return self.price
    }
    
    public func beverageName() -> String {
        return self.name
    }
}

extension Date {
    var simpleDateStyle : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.string(from: self)
        return date
    }
}
