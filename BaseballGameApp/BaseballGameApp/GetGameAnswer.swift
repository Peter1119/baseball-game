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
        return Array(1...9).shuffled().prefix(3).map(String.init).joined()
    }
}
