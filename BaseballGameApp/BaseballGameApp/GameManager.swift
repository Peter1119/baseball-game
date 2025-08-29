//
//  GameManager.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/28/25.
//

import Foundation

fileprivate enum GameState: String, CaseIterable {
    case start = "1"
    case showRecords = "2"
    case quit = "3"
    
    var description: String {
        switch self {
        case .start:
            return "\(self.rawValue). 게임 시작하기"
        case .showRecords:
            return "\(self.rawValue). 게임 기록 보기"
        case .quit:
            return "\(self.rawValue). 종료하기"
        }
    }
}

public class GameManager {
    private var currenctState: GameState?
    private var gameFactory: GameFactory
    private var gameRecordReader: GameRecordReading
    
    init(
        gameFactory: GameFactory,
        gameRecordReader: GameRecordReading
    ) {
        self.gameFactory = gameFactory
        self.gameRecordReader = gameRecordReader
    }
    
    public func start() {
        print("환영합니다! 원하시는 번호를 입력해주세요")

        while currenctState != .quit {
            print(GameState.allCases.map(\.description).joined(separator: " "))
            guard let input = readLine(),
                  let state = GameState(rawValue: input)
            else {
                print("올바르지 않은 입력입니다.\n")
                continue
            }
            
            switch state {
            case .start:
                currenctState = .start
                var game = gameFactory.createGame()
                let result = game.play()
                switch result {
                case .completed:
                    print("게임이 완료되었습니다!\n")
                case .quit:
                    print("게임을 중단했습니다.\n")
                }
            case .showRecords:
                currenctState = .showRecords
                print(gameRecordReader.execute())
            case .quit:
                currenctState = .quit
                print("종료하겠습니다.\n")
                break
            }
        }
    }
}
