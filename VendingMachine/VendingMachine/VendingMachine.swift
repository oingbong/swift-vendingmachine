//
//  VendingMachine.swift
//  VendingMachine
//
//  Created by 심 승민 on 2017. 12. 14..
//  Copyright © 2017년 JK. All rights reserved.
//

import Foundation

typealias Stock = Int
typealias Balance = Int
typealias Purchased = Int

// self.inventory를 Collection 프로토콜로 캡슐화.
class VendingMachine: Collection {
    static let sharedMachine = VendingMachine()
    private var stockManager: StockManager!
    private var moneyManager: MoneyManager!
    private init() {
        // 장부기록, 돈관리의 책임을 위임.
        self.stockManager = StockManager(self)
        self.moneyManager = MoneyManager(self)
    }

    // Collection 프로토콜 채택 시 필요한 stubs.
    var startIndex: Set<Beverage>.Index { return self.inventory.startIndex }
    var endIndex: Set<Beverage>.Index { return self.inventory.endIndex }

    subscript(position: Set<Beverage>.Index) -> Beverage {
        return self.inventory[position]
    }

    func index(after i: Index) -> Index {
        return self.inventory.index(after: i)
    }

    // 자판기 내 음료수 인스턴스 저장.
    private var inventory: Set<Beverage> = Set<Beverage>() {
        // 상태변화가 생길 때마다 장부 및 잔액을 업데이트.
        didSet(oldInventory) {
            // 재고를 넣을 때와 음료수를 빼먹을 때 둘 다 업데이트.
            self.stockManager.updateStock(oldInventory)
            self.stockManager.recordHistory(oldInventory)
            // 잔액은 음료수를 빼먹을 때만 업데이트.
            self.moneyManager.updateBalance(oldInventory)
        }
    }

    // 모든 메뉴의 재고를 10개씩 자판기에 공급.
    func fullSupply() {
        for menu in Menu.allValues {
            supply(beverageType: menu, 10)
        }
    }

    // 특정상품의 재고를 N개 공급.
    func supply(beverageType: Menu, _ addCount: Stock) {
        for _ in 0..<addCount {
            // 인벤토리에 추가.
            self.inventory.insert(beverageType.generate())
        }
    }

    // 구매가능한 음료 중 선택한 음료수를 반환.
    func popBeverage(_ menu: Menu) -> Beverage? {
        // 품절이 아닌 상품 중, 현재 금액으로 살 수 있는 메뉴 리스트를 받아옴.
        let affordableList = self.moneyManager.showAffordableList(from: self.stockManager.showSellingList())
        // 리스트에 선택한 상품이 있는 경우, 해당 음료수 반환. 없는 경우, nil 반환. (아무일도 일어나지 않음)
        guard affordableList.contains(menu) else { return nil }
        return pop(menu)
    }

    // 자판기 인벤토리에서 특정 메뉴의 음료수를 반환.
    private func pop(_ menu: VendingMachine.Menu) -> Beverage? {
        for beverage in self.inventory {
            if menu.description == beverage.description {
                return self.inventory.remove(beverage)
            }
        }
        return nil
    }

    // 주화 삽입.
    func insertMoney(_ money: MoneyManager.Unit) {
        self.moneyManager.insert(money: money)
    }

    // 잔액을 확인.
    func showBalance() -> Balance {
        return self.moneyManager.balance
    }

    // 전체 상품 재고를 (사전으로 표현하는) 종류별로 반환.
    func checkTheStock() -> [Menu.RawValue:Stock] {
        return self.stockManager.showStockList()
    }

    func showAffordableBeverages() -> [VendingMachine.Menu] {
        return self.moneyManager.showAffordableList(from: self.stockManager.showSellingList())
    }

    // 유통기한이 지난 재고 리스트 반환.
    func showExpiredBeverages(on day: Date) -> [Menu.RawValue:Stock] {
        return self.stockManager.showExpiredList(on: day)
    }

    // 시작이후 구매 상품 이력 반환.
    func showPurchasedList() -> [HistoryInfo] {
        return self.stockManager.showPurchasedHistory()
    }

    // 따뜻한 음료 리스트 리턴.
    func showHotBeverages() -> [Menu] {
        // 커피타입인 경우만 해당.
        return Menu.allValues.filter {
            guard let coffee = $0.generate() as? Coffee else { return false }
            return coffee.isHot
        }
    }

    // 선택 가능한 메뉴.
    enum Menu: String, CustomStringConvertible, EnumCollection {
        case strawberryMilk = "날마다딸기우유"
        case bananaMilk = "날마다바나나우유"
        case chocoMilk = "날마다초코우유"
        case coke = "다이어트콜라"
        case cider = "사이다"
        case fanta = "환타"
        case top = "티오피"
        case cantata = "칸타타"
        case georgia = "조지아"

        init?(_ beverageType: String) {
            switch beverageType {
            case Menu.strawberryMilk.description: self = .strawberryMilk
            case Menu.bananaMilk.description: self = .bananaMilk
            case Menu.chocoMilk.description: self = .chocoMilk
            case Menu.coke.description: self = .coke
            case Menu.cider.description: self = .cider
            case Menu.fanta.description: self = .fanta
            case Menu.top.description: self = .top
            case Menu.cantata.description: self = .cantata
            case Menu.georgia.description: self = .georgia
            default: return nil
            }
        }

        // Menu 열거형과 클래스들을 이어주는 역할.
        var description: String {
            // 각 메뉴의 Beverage 클래스명 반환.
            return String.init(describing: type(of: self.generate()))
        }

        // 각 메뉴의 가격은 노출 가능.
        var price: Int {
            return self.generate().price
        }

        // 각 메뉴별 Beverage 인스턴스 생성.
        fileprivate func generate() -> Beverage {
            var beverage = Beverage()
            switch self {
            case .strawberryMilk: beverage = StrawBerryMilk("서울우유", 200, 1000, self.rawValue, Date(timeIntervalSinceNow: 0), Date(timeIntervalSinceNow: 60*60*24*7), 210, manufacturerCode: 1001, packingMaterial: "종이")
            case .bananaMilk: beverage = BananaMilk("서울우유", 200, 1000, self.rawValue, Date(timeIntervalSinceNow: 0), Date(timeIntervalSinceNow: 60*60*24*7), 220, manufacturerCode: 1001, packingMaterial: "종이")
            case .chocoMilk: beverage = ChocoMilk("서울우유", 200, 1000, self.rawValue, Date(timeIntervalSinceNow: 0), Date(timeIntervalSinceNow: 60*60*24*7), 240, manufacturerCode: 1001, packingMaterial: "종이")
            case .coke: beverage = CokeSoftDrink("펩시", 350, 2000, self.rawValue, Date(timeIntervalSinceNow: 0), Date(timeIntervalSinceNow: 60*60*24*30*6), 250, carbonContent: 50)
            case .cider: beverage = CiderSoftDrink("롯데칠성음료", 350, 2000, self.rawValue, Date(timeIntervalSinceNow: 0), Date(timeIntervalSinceNow: 60*60*24*30*6), 250, carbonContent: 60)
            case .fanta: beverage = FantaSoftDrink("코카콜라컴퍼니", 350, 2000, self.rawValue, Date(timeIntervalSinceNow: 0), Date(timeIntervalSinceNow: 60*60*24*30*7), 300, carbonContent: 40)
            case .top: beverage = TopCoffee("맥심", 200, 2200, self.rawValue, Date(timeIntervalSinceNow: 0), Date(timeIntervalSinceNow: 60*60*24*14), 240, caffeineLevels: 20, isHot: true, isSweetened: true)
            case .cantata: beverage = CantataCoffee("롯데칠성음료", 200, 2200, self.rawValue, Date(timeIntervalSinceNow: 0), Date(timeIntervalSinceNow: 60*60*24*14), 250, caffeineLevels: 10, isHot: false, isSweetened: true)
            case .georgia: beverage = GeorgiaCoffee("코카콜라", 200, 2200, self.rawValue, Date(timeIntervalSinceNow: 0), Date(timeIntervalSinceNow: 60*60*24*2), 100, caffeineLevels: 25, isHot: true, isSweetened: false)
            }
            return beverage
        }

    }

}
