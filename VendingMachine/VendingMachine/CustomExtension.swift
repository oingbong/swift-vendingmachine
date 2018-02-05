//
//  CustomExtension.swift
//  VendingMachine
//
//  Created by YOUTH on 2018. 1. 27..
//  Copyright © 2018년 JK. All rights reserved.
//

import Foundation

// MARK: Extension Date type

extension Date {
    // 지정한 형태로 출력하기위한 description 속성
    var description: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"

        return dateFormatter.string(from: self)
    }

    init(yyyyMMdd: String) {
        // dateFormatter 초기화
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"

        // 입력된 String으로 Date생성
        self = dateFormatter.date(from: yyyyMMdd) ?? Date()
    }

    func isOutOfDate(validDuration: Int) -> Bool {
        let currentDate = Date() // 오늘날짜(프로그램 실행날짜) 구하기

        // 파라미터로 받은 사용기한(validDuration)을 통해 유통기한 계산
        let expiration = Calendar.current.date(byAdding: .day, value: validDuration, to: self) ?? Date()

        // 사용기한 + 제조일자 > 오늘날짜 = true
        return currentDate < expiration
    }
}

// MARK: Extension Dictionary

extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}

// MARK: EnumCollection protocol

public protocol EnumCollection: Hashable {
    static func cases() -> AnySequence<Self>
    static var allValues: [Self] { get }
}

public extension EnumCollection {

    public static func cases() -> AnySequence<Self> {
        return AnySequence { () -> AnyIterator<Self> in
            var raw = 0
            return AnyIterator {
                let current: Self = withUnsafePointer(to: &raw) { $0.withMemoryRebound(to: self, capacity: 1) { $0.pointee } }
                guard current.hashValue == raw else {
                    return nil
                }
                raw += 1
                return current
            }
        }
    }

    public static var allValues: [Self] {
        return Array(self.cases())
    }
}


