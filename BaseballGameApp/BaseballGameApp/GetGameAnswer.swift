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
    public func execute() -> String {
        guard let firstNum: Int = Array(0...9).randomElement(),
              let secondNum = Array(0...9).filter({ $0 != firstNum }).randomElement(),
              let thirdNum = Array(0...9).filter({ $0 != firstNum && $0 != secondNum }).randomElement()
        else {
            return ""
        }
        return "\(firstNum)\(secondNum)\(thirdNum)"
    }
}
