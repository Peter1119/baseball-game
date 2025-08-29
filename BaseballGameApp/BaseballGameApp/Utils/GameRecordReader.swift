//
//  GameRecordReader.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/29/25.
//

import Foundation

public protocol GameRecordReading {
    func execute() -> String
}

public struct GameRecordReader: GameRecordReading {
    public init() {}
    
    public func execute() -> String {
        guard let data = try? Data(contentsOf: URL(filePath: GameRecordFilePath.filePath)),
              let gameRecords = try? JSONDecoder().decode([GameRecord].self, from: data)else { return "기록이 없습니다." }
        
        var result = "< 게임 기록 보기 >\n"
        result += gameRecords.sorted(by: { $0.date < $1.date }).enumerated().map { (index, value) -> String in
            return "\(index + 1)번째 게임 : 시도 횟수 - \(value.tries)"
        }.joined(separator: "\n")
        
        return result
    }
}
