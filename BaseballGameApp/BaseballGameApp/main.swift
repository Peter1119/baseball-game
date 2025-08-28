//
//  main.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/27/25.
//

import Foundation

let getGameAnswer: GetGameAnswerProtocol = GetGameAnswer()
let baseballGame = BaseballGame(getGameAnswer: getGameAnswer)

baseballGame.start()
