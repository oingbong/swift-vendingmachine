//
//  UintTestVendingmachine.swift
//  UintTestVendingmachine
//
//  Created by Yoda Codd on 2018. 7. 23..
//  Copyright © 2018년 JK. All rights reserved.
//

import XCTest

class UintTestVendingmachine: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEnergeDrinkIsNoCaffeine() {
        let eDrink1 = EnergyDrink(barnd: "Mail", size: 200, price: 1000, name: "초코초코", manufacturingDate: "20181023",zeroCaffeine:true)
        XCTAssert(eDrink1!.isNoCaffeine())
    }
    func testEnergeDrinkIsNoCaffeineFalse() {
        let eDrink1 = EnergyDrink(barnd: "Mail", size: 200, price: 1000, name: "초코초코", manufacturingDate: "20181023",zeroCaffeine:false)
        XCTAssert(!(eDrink1!.isNoCaffeine()))
    }
    
    func testmakeVendinMachine(){
        _ = VendingMachine()
        XCTAssert(true)
    }
    
    func testAddDrink(){
        var inven = DrinkInventory()
        let eDrink1 = EnergyDrink(barnd: "Mail", size: 200, price: 1000, name: "초코초코", manufacturingDate: "20181023",zeroCaffeine:false)
        if inven.addInventory(drink: eDrink1) == nil {
            XCTAssert(false)
        }
        else { XCTAssert(true) }
    }
    
    func testGetTotalDrinkDetailFuncTrue(){
        var inven = DrinkInventory()
        let eDrink1 = EnergyDrink(barnd: "Mail", size: 200, price: 1000, name: "핫식스", manufacturingDate: "20181023",zeroCaffeine:false)
        inven.addInventory(drink: eDrink1)
        let totalInven = inven.getTotalDrinkDetail()
        if totalInven.count == 0 {            
            XCTAssert(false)
        }
        else { XCTAssert(true) }
    }
    func testGetTotalDrinkDetailFuncFail(){
        var inven = DrinkInventory()
        let eDrink1 = EnergyDrink(barnd: "Mail", size: 200, price: 1000, name: "핫식스", manufacturingDate: "20181023",zeroCaffeine:false)
        inven.addInventory(drink: eDrink1)
        let totalInven = inven.getTotalDrinkDetail()
        if totalInven.count == 0 {
            XCTAssert(true)
        }
        else { XCTAssert(false) }
    }
    
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}