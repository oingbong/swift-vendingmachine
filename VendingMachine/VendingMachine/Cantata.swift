//
//  Cantata.swift
//  VendingMachine
//
//  Created by 김수현 on 2018. 5. 24..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

class Cantata: Coffee {
    
    private let kind = "Cantata"
    private let temperature = 60
    
    override init(_ brand: String, _ volume: Int, _ price: Int, _ name: String, _ date: Date) {
        super.init(brand, volume, price, name, date)
    }
    
    override var description: String {
        return "\(kind) - \(super.description)"
    }
    
    override func isHot() -> Bool {
        return 50 < self.temperature
    }
}