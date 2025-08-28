//
//  BaseballGameError.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/27/25.
//

import Foundation

public enum BaseballGameError: Error {
    case inValidInput
    case notMatch(strike: Int, ball: Int)
}

extension BaseballGameError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .inValidInput:
            return "올바르지 않은 입력값입니다."
        case .notMatch(let strike, let ball):
            var result = String()
            if strike > 0 {
                result += "\(strike)스트라이크 "
            }
            
            if ball > 0 {
                result += "\(ball)볼"
            }
            return result.isEmpty ? "Nothing" : result.trimmingCharacters(in: .whitespaces)
        }
    }
}
