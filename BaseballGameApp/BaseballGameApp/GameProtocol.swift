//
//  GameProtocol.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/28/25.
//

import Foundation

public enum GameResult {
    case completed
    case quit
}

public protocol Game {
    func play() -> GameResult
}
