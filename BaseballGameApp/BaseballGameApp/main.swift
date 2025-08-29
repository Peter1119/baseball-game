//
//  main.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/27/25.
//

import Foundation

let gameFactory = BaseballGameFactory(
    randomNumberGenerator: RandomNumberGenerator(),
    gameRecorder: GamePlayRecorder()
)
let gameManager = GameManager(gameFactory: gameFactory)

gameManager.start()
