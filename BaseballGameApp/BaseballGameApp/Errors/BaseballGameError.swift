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
        case .notMatch(strike: let strike, ball: let ball):
            if strike == 0 && ball == 0 {
                return "Nothing"
            } else {
                return "스트라이크: \(strike), 볼: \(ball)"
            }
        }
    }
}
