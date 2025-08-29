//
//  main.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/27/25.
//

import Foundation

let baseballGame = BaseballGame(
    answerGenerator: RandomNumberGenerator(),
    gameRecorder: GamePlayRecorder()
)
let gameManager = GameManager(game: baseballGame)

gameManager.start()
