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
    private let game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    public func start() {
        print("환영합니다! 원하시는 번호를 입력해주세요")
        print(GameState.allCases.map(\.description).joined(separator: " "))

        while currenctState != .quit {
            guard let input = readLine(),
                  let state = GameState(rawValue: input)
            else {
                print("올바르지 않은 입력입니다.")
                continue
            }
            
            switch state {
            case .start:
                currenctState = .start
                game.play()
            case .showRecords:
                currenctState = .showRecords
                print("기록을 보여주겠습니다.")
            case .quit:
                currenctState = .quit
                print("종료하겠습니다.")
                break
            }
        }
    }
}
