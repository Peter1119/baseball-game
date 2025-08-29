//
//  GameFactory.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/29/25.
//

import Foundation

public protocol GameFactory {
    func createGame() -> Game
}

public struct BaseballGameFactory: GameFactory {
    private let randomNumberGenerator: RandomNumberGenerating
    private let gameRecorder: GamePlayRecording
    
    public init(
        randomNumberGenerator: RandomNumberGenerating,
        gameRecorder: GamePlayRecording
    ) {
        self.randomNumberGenerator = randomNumberGenerator
        self.gameRecorder = gameRecorder
    }
    
    public func createGame() -> Game {
        return BaseballGame(
            answerGenerator: randomNumberGenerator,
            gameRecorder: gameRecorder
        )
    }
}
