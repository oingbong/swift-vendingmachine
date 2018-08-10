//
//  OutputView.swift
//  VendingMachine
//
//  Created by Yoda Codd on 2018. 8. 9..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

struct OutputView {
    /// 시작 화면
    func mainMenu(){
        print("자판기 메인메뉴 입니다.")
    }
    /// 자판기 금액을 리턴한다
    func printMoney(money:Int){
        print("현재 자판기에 입력된 금액은 \(money)원 입니다.")
    }
    
    /// 재고 출력 메세지
    func printGettableDrink(drinks:[String]){
        print("---현재 구매가능한 음료수---")
        for drink in drinks {
            print("\(drinks.index(of: drink)!+1). \(drink)")
        }
        print("----------------------")
    }
    
    /// 잘못된 금액 입력시 출력메세지
    func wrongMoney(){
        print( "잘못된 금액입니다.")
    }
    
    /// 잘못된 메뉴 선택시 출력메세지
    func wrongMenu(){
        print("잘못된 메뉴입니다")
    }
    
    /// 종료시 출력메세지
    func quitMessage(){
        print("자판기를 종료합니다.")
    }
}
