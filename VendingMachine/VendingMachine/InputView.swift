//
//  InputView.swift
//  VendingMachine
//
//  Created by YOUTH on 2018. 1. 30..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

enum ProgramMode {
    case Admin
    case User
    case None
    case Quit
}

enum AdminMenu {
    case AddItem
    case DeleteItem
    case None
    case Quit
}

struct InputView {

    func askSelectMode() -> ProgramMode {
        print("자판기를 시작합니다.(종료를 원하면 \"q\"입력)\n1.관리자 모드\n2.사용자 모드\n> ")
        var mode = ProgramMode.None
        let input = readLine() ?? ""

        if input == "q" {
            mode = .Quit
        } else {
            let inputNumber = Int(input) ?? 0
            switch inputNumber {
            case 1:
                mode = .Admin
            case 2:
                mode = .User
            default:
                mode = .None
            }
        }
        return mode
    }

    func askSelectOption(message: CustomStringConvertible) -> [Int] {
        print(message)
        let input = readLine() ?? ""
        if input.contains(" ") {
            let splitInput = input.split(separator: " ")
            let options = splitInput.map({ Int($0) ?? 0 })
            return options
        } else if input == "q" {
            return [-1]
        } else {
            return [0]
        }
    }

    func askAdminExecuteOption(message: CustomStringConvertible) -> (action: AdminMenu, option: Int) {
        print(message)
        var result = (action: AdminMenu.None, option: 0)
        let input = readLine() ?? ""

        if input.contains(" ") {
            let splitInput = (input.split(separator: " ")).map({ Int($0) ?? 0 })
            switch splitInput[0] {
            case 1: result = (action: .AddItem, option: splitInput[1])
            case 2: result = (action: .DeleteItem, option: splitInput[1])
            default: return result
            }
        } else if input == "q" {
            result = (action: .Quit, option: 0)
        } else {
            return result
        }
        return result
    }


    // InputView와 InputChecker를 분리하려고했지만 기능이 한 개씩 밖에 없어서 InputView에 Input값을 검사하는 메소드 추가함
    func checkValid(input: [Int]) -> [Int] {
        switch input[0] {
        case 1:
            if input[1] > 0 {
                return input
            }
        case 2:
            if (1 <= input[1]) && (input[1] <= 6) {
                return input
            }
        case -1: return [-1] // 컨트롤러에서의 종료조건
        default : return [0]
        }

        return [0]
    }

}

