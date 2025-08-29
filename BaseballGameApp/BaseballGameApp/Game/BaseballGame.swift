//
//  BaseballGame.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/27/25.
//

import Foundation

public struct BaseballGame: Game {
    public var gameRecorder: (any GamePlayRecording)?
    private let answerGenerator: RandomNumberGenerating
    private let answer: String
    private var tries: Int = 0
    
    public init(
        answerGenerator: RandomNumberGenerating,
        gameRecorder: (any GamePlayRecording)? = nil
    ) {
        self.answerGenerator = answerGenerator
        self.gameRecorder = gameRecorder
        self.answer = answerGenerator.execute()
    }
    
    public mutating func play() -> GameResult {
        print("< 게임을 시작합니다 >")
        while true {
            print("숫자를 입력하세요.")
            incrementTries()
            guard let input = readLine() else {
                print("입력값 오류입니다. 다시 시도해주세요.")
                break
            }
            
            do {
                try progress(input)
                end()
                return .completed
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return .quit
    }
    
    private func end() {
        print("정답입니다!")
        gameRecorder?.execute(self.tries)
    }
    
    private mutating func incrementTries() {
        tries += 1
    }
}

extension BaseballGame {
    /// 게임 진행 로직
    ///
    private func progress(_ guess: String) throws {
        // input 빈칸과 줄바꿈 제거
        let guess = guess.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // 유효성 검사
        guard let _ = try? validate(guess, with: answer) else {
            throw BaseballGameError.inValidInput
        }
        
        var strikeCount = 0
        var ballCount = 0
        for i in 0..<guess.count {
            let guessIndex = guess.index(guess.startIndex, offsetBy: i)
            let guessChar = guess[guessIndex]
            
            // 동일한 위치에 동일한 값이 있다면 strike
            if guessChar == answer[answer.index(answer.startIndex, offsetBy: i)] {
                strikeCount += 1
                // 동일한 Character를 갖고 있다면 ball
            } else if answer.contains(guessChar) {
                ballCount += 1
            }
        }
         
        // strike 갯수가 answer의 갯수와 동일하다면 통과
        guard strikeCount == answer.count else {
            throw BaseballGameError.notMatch(strike: strikeCount, ball: ballCount)
        }
        return
    }
    
    /// input 유효성 검사 메서드
    ///
    /// 모두 숫자가 아니거나 길이가 3이 아니라면 에러 방출
    private func validate(_ guess: String, with answer: String) throws {
        if guess.count != answer.count {
            throw ValidateGuessError.invalidLength
        }
        
        if !guess.allSatisfy({ $0.isNumber }) {
            throw ValidateGuessError.notDigits
        }
    }
}
