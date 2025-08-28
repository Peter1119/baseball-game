//
//  GetGameAnswer.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/27/25.
//

import Foundation

public protocol GetGameAnswerProtocol {
    func execute() -> String
}

public struct GetGameAnswer: GetGameAnswerProtocol {
    private let numberOfDigits: Int = 3

    public func execute() -> String {
        guard let firstNum = Array(1...9).randomElement() else { return String() }
        let others = Array(0...9).filter { $0 != firstNum }.shuffled().prefix(numberOfDigits - 1)
        return String(firstNum) + others.map(String.init).joined()
    }
}
