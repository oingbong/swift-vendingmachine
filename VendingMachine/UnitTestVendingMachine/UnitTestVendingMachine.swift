//
//  UnitTestVendingMachine.swift
//  UnitTestVendingMachine
//
//  Created by oingbong on 2018. 9. 20..
//  Copyright © 2018년 JK. All rights reserved.
//

import XCTest

class UnitTestVendingMachine: XCTestCase {
    
    func convertSeconds(_ date: Int) -> Double {
        // 1일 : 86400초
        return Double(date * 86400)
    }
    
    // AdminMode
    func test_AdminMode_유통기한지난재고_삭제() {
        let date = Date(timeIntervalSinceNow: -convertSeconds(10))
        let expiredDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke1 = Coke(dateOfManufacture: date)
        let coke2 = Coke(dateOfManufacture: date)
        let strawberryMilk1 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk2 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk3 = StrawberryMilk(dateOfManufacture: date)
        let topCoffee1 = TOP(dateOfManufacture: expiredDate)
        let topCoffee2 = TOP(dateOfManufacture: expiredDate)
        let beverages = [[coke1,coke2] , [strawberryMilk1,strawberryMilk2,strawberryMilk3],[topCoffee1,topCoffee2]]
        // 재고 추가
        let vendingMachine = VendingMachine(with: beverages)
        
        // 유통기한 지난 음료
        var expiredBeverages = [[Beverage:Int]]()
        var expiredBeverage = [Beverage:Int]()
        expiredBeverage.updateValue(0, forKey: topCoffee1)
        expiredBeverage.updateValue(1, forKey: topCoffee2)
        expiredBeverages.append(expiredBeverage)
        
        let compareBeverages = [[coke1,coke2] , [strawberryMilk1,strawberryMilk2,strawberryMilk3]]
        
        do {
            _ = try vendingMachine.removeExpiredBeverage(with: expiredBeverages)
            
        } catch let error {
            print(error)
        }
        if let stockList = vendingMachine.stockList() {
            let list = stockList.filter({ $0.count > 0 })
            XCTAssertEqual(list, compareBeverages)
        }
        
    }
    
    // AdminMode
    func test_AdminMode_유통기한지난재고_확인() {
        let date = Date(timeIntervalSinceNow: -convertSeconds(10))
        let expiredDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke1 = Coke(dateOfManufacture: date)
        let coke2 = Coke(dateOfManufacture: date)
        let strawberryMilk1 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk2 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk3 = StrawberryMilk(dateOfManufacture: date)
        let topCoffee1 = TOP(dateOfManufacture: expiredDate)
        let topCoffee2 = TOP(dateOfManufacture: expiredDate)
        let beverages = [[coke1,coke2] , [strawberryMilk1,strawberryMilk2,strawberryMilk3],[topCoffee1,topCoffee2]]
        // 재고 추가
        let vendingMachine = VendingMachine(with: beverages)
        
        // 유통기한 지난 음료
        var expiredBeverages = [[Beverage:Int]]()
        var expiredBeverage = [Beverage:Int]()
        expiredBeverage.updateValue(0, forKey: topCoffee1)
        expiredBeverage.updateValue(1, forKey: topCoffee2)
        expiredBeverages.append(expiredBeverage)

        do {
            XCTAssertEqual(try vendingMachine.expiredBeverages(), expiredBeverages)
        } catch let error {
            print(error)
        }
    }
    
    // AdminMode
    func test_AdminMode_재고삭제() {
        let date = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke1 = Coke(dateOfManufacture: date)
        let coke2 = Coke(dateOfManufacture: date)
        let strawberryMilk1 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk2 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk3 = StrawberryMilk(dateOfManufacture: date)
        let beverages = [[coke1,coke2] , [strawberryMilk1,strawberryMilk2,strawberryMilk3]]
        // 재고 추가
        let vendingMachine = VendingMachine(with: beverages)

        // 입력값에서는 index 1 부터 시작
        _ = vendingMachine.removeStock(target: 1, amount: 1)
        _ = vendingMachine.removeStock(target: 2, amount: 1)
        
        let compareBeverages = [[coke2] , [strawberryMilk2,strawberryMilk3]]
        
        XCTAssertEqual(vendingMachine.stockList(), compareBeverages)
    }
    
    // AdminMode
    func test_AdminMode_재고추가() {
        let date = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke1 = Coke(dateOfManufacture: date)
        let coke2 = Coke(dateOfManufacture: date)
        let strawberryMilk1 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk2 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk3 = StrawberryMilk(dateOfManufacture: date)
        let beverages = [[coke1,coke2] , [strawberryMilk1,strawberryMilk2,strawberryMilk3]]
        // 재고 추가
        let vendingMachine = VendingMachine(with: beverages)

        let topCoffee1 = TOP(dateOfManufacture: date)
        let topCoffee2 = TOP(dateOfManufacture: date)
        let addBeverages = [topCoffee1 , topCoffee2]
        _ = vendingMachine.addStock(with: addBeverages)
        
        let compareBeverages = [[coke1,coke2] , [strawberryMilk1,strawberryMilk2,strawberryMilk3] , [topCoffee1,topCoffee2]]
        
        XCTAssertEqual(vendingMachine.stockList(), compareBeverages)
    }
    
    // UserMode
    func test_UserMode_잔액추가() {
        let date = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke1 = Coke(dateOfManufacture: date)
        let coke2 = Coke(dateOfManufacture: date)
        let strawberryMilk1 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk2 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk3 = StrawberryMilk(dateOfManufacture: date)
        let beverages = [[coke1,coke2] , [strawberryMilk1,strawberryMilk2,strawberryMilk3]]
        // 재고 추가
        let vendingMachine = VendingMachine(with: beverages)
        // 잔액 추가
        vendingMachine.addBalance(value: 10000)
        
        let userMode = UserMode(with: vendingMachine)
        do {
            _ = try userMode.selectMenu(with: Menu.addBalance , value: 5000)
            XCTAssertEqual(vendingMachine.presentBalance(), 15000)
        } catch let error {
            print(error)
        }
    }
    
    // UserMode
    func test_UserMode_통합테스트() {
        let date = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke1 = Coke(dateOfManufacture: date)
        let coke2 = Coke(dateOfManufacture: date)
        let strawberryMilk1 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk2 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk3 = StrawberryMilk(dateOfManufacture: date)
        let beverages = [[coke1,coke2] , [strawberryMilk1,strawberryMilk2,strawberryMilk3]]
        // 재고 추가
        let vendingMachine = VendingMachine(with: beverages)
        // 잔액 추가
        vendingMachine.addBalance(value: 10000)

        let userMode = UserMode(with: vendingMachine)
        do {
            _ = try userMode.selectMenu(with: Menu.purchaseBeverage , value: 2)
            _ = try userMode.selectMenu(with: Menu.purchaseBeverage , value: 2)
            _ = try userMode.selectMenu(with: Menu.purchaseBeverage , value: 2)
            _ = try userMode.selectMenu(with: Menu.purchaseBeverage , value: 1)
            _ = try userMode.selectMenu(with: Menu.purchaseBeverage , value: 1)
            let compareBeverages = [strawberryMilk1,strawberryMilk2,strawberryMilk3,coke1,coke2]
            XCTAssertEqual(vendingMachine.historyList(), compareBeverages)
        } catch let error {
            print(error)
        }
    }
    
    func testHistory_구매목록() {
        let date = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke1 = Coke(dateOfManufacture: date)
        let coke2 = Coke(dateOfManufacture: date)
        let strawberryMilk1 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk2 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk3 = StrawberryMilk(dateOfManufacture: date)
        let beverages = [[coke1,coke2] , [strawberryMilk1,strawberryMilk2,strawberryMilk3]]
        // 재고 추가
        let vendingMachine = VendingMachine(with: beverages)
        // 잔액 추가
        vendingMachine.addBalance(value: 10000)
        _ = vendingMachine.remove(target: 1)
        _ = vendingMachine.remove(target: 1)
        let compareBeverages = [coke1,coke2]
        XCTAssertEqual(vendingMachine.historyList(), compareBeverages)
    }
    
    // VendingMachine
    func testRemove_구매할때리스트에서삭제O() {
        let date = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke1 = Coke(dateOfManufacture: date)
        let coke2 = Coke(dateOfManufacture: date)
        let strawberryMilk1 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk2 = StrawberryMilk(dateOfManufacture: date)
        let strawberryMilk3 = StrawberryMilk(dateOfManufacture: date)
        let beverages = [[coke1,coke2] , [strawberryMilk1,strawberryMilk2,strawberryMilk3]]
        let vendingMachine = VendingMachine(with: beverages)
        _ = vendingMachine.remove(target: 1)
        let compareBeverages = [[coke2] , [strawberryMilk1,strawberryMilk2,strawberryMilk3]]
        XCTAssertEqual(vendingMachine.stockList(), compareBeverages)
    }
    
    // VendingMachine
    func testIsAvailablePurchase_구매가능O(){
        let date = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke = Coke(dateOfManufacture: date)
        let beverages = [[coke]]
        let vendingMachine = VendingMachine(with: beverages)
        XCTAssertTrue(try vendingMachine.isAvailablePurchase(target: 1, balance: 3000))
    }
    
    // VendingMachine
    func testIsAvailablePurchase_구매가능X(){
        let date = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke = Coke(dateOfManufacture: date)
        let beverages = [[coke]]
        let vendingMachine = VendingMachine(with: beverages)
        XCTAssertFalse(try vendingMachine.isAvailablePurchase(target: 1, balance: 800))
    }
    
    // Beverage
    func testValidate_유통기한초과O() {
        let cokeDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke = Coke(calorie: 300, sodium: 120, brand: "펩시", capacity: 350, price: 1500, name: "다이어트콜라", dateOfManufacture: cokeDate, manufacturer: "펩시")
        let today = Date(timeIntervalSinceNow: 0)
        let isOverExpirationDate = coke.isExpirationDate(with: today)
        XCTAssertTrue(isOverExpirationDate)
    }

    // Beverage
    func testIsLargeCapacity_대용량음료O() {
        let cokeDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke = Coke(calorie: 300, sodium: 120, brand: "펩시", capacity: 350, price: 1500, name: "다이어트콜라", dateOfManufacture: cokeDate, manufacturer: "펩시")
        XCTAssertTrue(coke.isLargeCapacity())
    }
    
    // Beverage
    func testIsLargeCapacity_대용량음료X() {
        let cokeDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke = Coke(calorie: 300, sodium: 120, brand: "펩시", capacity: 120, price: 1500, name: "다이어트콜라", dateOfManufacture: cokeDate, manufacturer: "펩시")
        XCTAssertFalse(coke.isLargeCapacity())
    }
    
    // Milk
    func testIsLowFat_저지방O() {
        let strawBerryDate = Date(timeIntervalSinceNow: -convertSeconds(10))
        let strawberryMilk = StrawberryMilk(flavor: Flavor.light, fat: 0.2, brand: "매일우유", capacity: 125, price: 1200, name: "유기농딸기우유", dateOfManufacture: strawBerryDate, manufacturer: "매일우유")
        XCTAssertTrue(strawberryMilk.isLowFat())
    }
    
    // Milk
    func testIsHighFat_저지방X() {
        let strawBerryDate = Date(timeIntervalSinceNow: -convertSeconds(10))
        let strawberryMilk = StrawberryMilk(flavor: Flavor.light, fat: 0.8, brand: "매일우유", capacity: 125, price: 1200, name: "유기농딸기우유", dateOfManufacture: strawBerryDate, manufacturer: "매일우유")
        XCTAssertFalse(strawberryMilk.isLowFat())
    }
    
    // StrawberryMilk
    func testIsNoneFlovor_향X() {
        let strawBerryDate = Date(timeIntervalSinceNow: -convertSeconds(10))
        let strawberryMilk = StrawberryMilk(flavor: Flavor.none, fat: 0.2, brand: "매일우유", capacity: 125, price: 1200, name: "유기농딸기우유", dateOfManufacture: strawBerryDate, manufacturer: "매일우유")
        XCTAssertTrue(strawberryMilk.isNoneFlavor())
    }
    
    // StrawberryMilk
    func testIsNoneFlovor_향O() {
        let strawBerryDate = Date(timeIntervalSinceNow: -convertSeconds(10))
        let strawberryMilk = StrawberryMilk(flavor: Flavor.light, fat: 0.2, brand: "매일우유", capacity: 125, price: 1200, name: "유기농딸기우유", dateOfManufacture: strawBerryDate, manufacturer: "매일우유")
        XCTAssertFalse(strawberryMilk.isNoneFlavor())
    }
    
    // ChocolateMilk
    func testIsLowConcentration_저농도O() {
        let chocolateDate = Date(timeIntervalSinceNow: -convertSeconds(10))
        let chocolateMilk = ChocolateMilk(concentration: 0.1, fat: 0.7, brand: "서울우유", capacity: 200, price: 900, name: "서울우유초코우유", dateOfManufacture: chocolateDate, manufacturer: "서울우유")
        XCTAssertTrue(chocolateMilk.isLowConcentration())
    }
    
    // ChocolateMilk
    func testIsLowConcentration_고농도O() {
        let chocolateDate = Date(timeIntervalSinceNow: -convertSeconds(10))
        let chocolateMilk = ChocolateMilk(concentration: 0.8, fat: 0.7, brand: "서울우유", capacity: 200, price: 900, name: "서울우유초코우유", dateOfManufacture: chocolateDate, manufacturer: "서울우유")
        XCTAssertFalse(chocolateMilk.isLowConcentration())
    }
    
    // BananaMilk
    func testIsWhiteColor_흰색바나나우유O() {
        let bananaDate = Date(timeIntervalSinceNow: -convertSeconds(10))
        let bananaMilk = BananaMilk(color: BananaMilkColor.white, fat: 0.4, brand: "매일우유", capacity: 240, price: 1500, name: "바나나는원래하얗다", dateOfManufacture: bananaDate, manufacturer: "매일우유")
        XCTAssertTrue(bananaMilk.isWhiteColor())
    }
    
    // BananaMilk
    func testIsWhiteColor_흰색바나나우유X() {
        let bananaDate = Date(timeIntervalSinceNow: -convertSeconds(10))
        let bananaMilk = BananaMilk(color: BananaMilkColor.yellow, fat: 0.4, brand: "매일우유", capacity: 240, price: 1500, name: "바나나는원래하얗다", dateOfManufacture: bananaDate, manufacturer: "매일우유")
        XCTAssertFalse(bananaMilk.isWhiteColor())
    }
    
    // Soda
    func testIsLowSodium_저나트륨O() {
        let cokeDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke = Coke(calorie: 300, sodium: 30, brand: "펩시", capacity: 350, price: 1500, name: "다이어트콜라", dateOfManufacture: cokeDate, manufacturer: "펩시")
        XCTAssertTrue(coke.isLowSodium())
    }
    
    // Soda
    func testIsLowSodium_저나트륨X() {
        let cokeDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke = Coke(calorie: 300, sodium: 200, brand: "펩시", capacity: 350, price: 1500, name: "다이어트콜라", dateOfManufacture: cokeDate, manufacturer: "펩시")
        XCTAssertFalse(coke.isLowSodium())
    }
    
    // Coke
    func testIsLowCalorie_저칼로리O() {
        let cokeDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke = Coke(calorie: 90, sodium: 200, brand: "펩시", capacity: 350, price: 1500, name: "다이어트콜라", dateOfManufacture: cokeDate, manufacturer: "펩시")
        XCTAssertTrue(coke.isLowCalorie())
    }
    
    // Coke
    func testIsLowCalorie_저칼로리X() {
        let cokeDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coke = Coke(calorie: 110, sodium: 200, brand: "펩시", capacity: 350, price: 1500, name: "펩시콜라", dateOfManufacture: cokeDate, manufacturer: "펩시")
        XCTAssertFalse(coke.isLowCalorie())
    }
    
    // Cider
    func testIsNoneTransFat_트랜스지방X() {
        let ciderDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let cider = Cider(transFat: 0, sodium: 140, brand: "롯데", capacity: 355, price: 1100, name: "칠성사이다", dateOfManufacture: ciderDate, manufacturer: "롯데")
        XCTAssertTrue(cider.isNoneTransFat())
    }
    
    // Cider
    func testIsNoneTransFat_트랜스지방O() {
        let ciderDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let cider = Cider(transFat: 100, sodium: 140, brand: "롯데칠성음료", capacity: 355, price: 1100, name: "칠성사이다", dateOfManufacture: ciderDate, manufacturer: "롯데칠성음료")
        XCTAssertFalse(cider.isNoneTransFat())
    }
    
    // Fanta
    func testIsOrangeTaste_오렌지향() {
        let fantaDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let fanta = Fanta(taste: FantaTaste.orange, sodium: 100, brand: "코카콜라", capacity: 355, price: 900, name: "오렌지맛환타", dateOfManufacture: fantaDate, manufacturer: "코카콜라")
        XCTAssertTrue(fanta.isOrangeTaste())
    }
    
    // Fanta
    func testIsOrangeTaste_파인애플향() {
        let fantaDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let fanta = Fanta(taste: FantaTaste.pineapple, sodium: 100, brand: "코카콜라", capacity: 355, price: 900, name: "오렌지맛환타", dateOfManufacture: fantaDate, manufacturer: "코카콜라")
        XCTAssertFalse(fanta.isOrangeTaste())
    }
    
    // Coffee
    func testIsNoneCaffeine_디카페인() {
        let coffeeDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coffee = Coffee(caffeine: 0, brand: "맥심", capacity: 275, price: 1800, name: "TOP커피", dateOfManufacture: coffeeDate, manufacturer: "맥심")
        XCTAssertTrue(coffee.isNoneCaffeine())
    }
    
    // Coffee
    func testIsNoneCaffeine_카페인() {
        let coffeeDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let coffee = Coffee(caffeine: 120, brand: "맥심", capacity: 275, price: 1800, name: "TOP커피", dateOfManufacture: coffeeDate, manufacturer: "맥심")
        XCTAssertFalse(coffee.isNoneCaffeine())
    }
    
    // TOP
    func testIsHot_뜨거운음료() {
        let topDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let top = TOP(hot: true, caffeine: 120, brand: "맥심", capacity: 275, price: 1800, name: "TOP커피", dateOfManufacture: topDate, manufacturer: "맥심")
        XCTAssertTrue(top.isHot())
    }
    
    // TOP
    func testIsHot_차가운음료() {
        let topDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let top = TOP(hot: false, caffeine: 120, brand: "맥심", capacity: 275, price: 1800, name: "TOP커피", dateOfManufacture: topDate, manufacturer: "맥심")
        XCTAssertFalse(top.isHot())
    }
    
    // Cantata
    func testIsSugarFree_무가당() {
        let cantataDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let cantata = Cantata(sugarFree: true, caffeine: 100, brand: "롯데칠성음료", capacity: 275, price: 1400, name: "칸타타", dateOfManufacture: cantataDate, manufacturer: "롯데칠성음료")
        XCTAssertTrue(cantata.isSugarFree())
    }
    
    // Cantata
    func testIsSugarFree_유가당() {
        let cantataDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let cantata = Cantata(sugarFree: false, caffeine: 100, brand: "롯데칠성음료", capacity: 275, price: 1400, name: "칸타타", dateOfManufacture: cantataDate, manufacturer: "롯데칠성음료")
        XCTAssertFalse(cantata.isSugarFree())
    }
    
    // Georgia
    func testIsCan_캔음료() {
        let georgiaDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let georgia = Georgia(packageMaterial: Material.can, caffeine: 80, brand: "코카콜라", capacity: 240, price: 1800, name: "조지아", dateOfManufacture: georgiaDate, manufacturer: "코카콜라")
        XCTAssertTrue(georgia.isCan())
    }
    
    // Georgia
    func testIsCan_플라스틱음료() {
        let georgiaDate = Date(timeIntervalSinceNow: -convertSeconds(15))
        let georgia = Georgia(packageMaterial: Material.plastic, caffeine: 100, brand: "코카콜라", capacity: 270, price: 1800, name: "조지아", dateOfManufacture: georgiaDate, manufacturer: "코카콜라")
        XCTAssertFalse(georgia.isCan())
    }
    
}
