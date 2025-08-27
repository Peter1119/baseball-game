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
        let firstNum: Int = Int.random(in: 1...9)
        let otherNums = Array(0...9)
            .filter({ $0 != firstNum })
            .shuffled()
            .prefix(2)
        
        let result = [firstNum] + otherNums
        
        return result.map { String($0) }.joined()
    }
}
