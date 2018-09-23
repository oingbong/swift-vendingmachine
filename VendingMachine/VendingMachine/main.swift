//
//  main.swift
//  VendingMachine
//
//  Created by JK on 11/10/2017.
//  Copyright © 2017 JK. All rights reserved.
//

import Foundation

struct VendingMachine {
    var inventory = Inventory()
    var customer = Customer()
    
    func run() throws {
        // 메뉴 출력
        // 1. 잔액 2. 재고 3. 선택목록 리스트
        let balance = customer.presentBalance()
        OutputView.printPresentBalance(with: balance)
        let list = self.inventory.list()
        OutputView.printInventoryList(with: list)
        OutputView.printSelectMenu()
        
        // 입력값 받기
        let (type, value) = try InputView.selectMenuType()
        
        // 메뉴 선택
        Menu.select(type: type, with: value)
    }
}

do {
    let vendingMachine = VendingMachine()
    try vendingMachine.run()
} catch {
    print(InputError.inputError)
}
