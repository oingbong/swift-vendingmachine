//
//  MessageMaker.swift
//  VendingMachine
//
//  Created by yuaming on 2018. 1. 24..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct MessageMaker {
    func makeAdminViewMessage(_ machine: InventoryCountable) -> String {
        return """
        관리자 모드
        \(viewListOfCurrentBeverage(machine))
        1. \(AdminMode.addBeverages.description)
        2. \(AdminMode.substractBeverages.description)
        """
    }
    
    func makeUserViewMessage(_ machine: InventoryCountable & Userable) -> String {
        let currentChange = viewCurrentChange(machine)
        return """
        현재 투입한 금액이 \(currentChange)원입니다. 다음과 같은 음료가 있습니다.
        \(currentChange == 0 ? viewCurrentInventory(machine) : viewListOfCurrentBeverage(machine))
        1. \(UserMode.insertMoney.description)
        2. \(UserMode.buyBeverage.description)
        """
    }
    
    func viewCurrentChange(_ machine: Userable) -> Int {
        return machine.countChange()
    }
    
    private func viewCurrentInventory(_ machine: InventoryCountable) -> String {
        return machine.countCurrentInventory().reduce("=> ") {
            $0 + $1.beverageMenu.makeInstance().description + "(" + String($1.quantity) + "개) "
        }
    }
    
    private func viewListOfCurrentBeverage(_ machine: InventoryCountable) -> String {
        var number = 0
        return BeverageMenu.map({
            let beverage = $0.makeInstance()
            number = number + 1
            return String(number) + ") " + beverage.description + " " + String(beverage.price.countChange()) + "원(" +  String(machine.countBeverageQuantity(beverageMenu: $0)) + "개)"
        }).joined(separator: "\n")
    }
}