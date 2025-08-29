//
//  GamePlayRecorder.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/29/25.
//

import Foundation

public protocol GamePlayRecording {
    func incrementPlayCount()
    func record()
    func reset()
}

public class GamePlayRecorder: GamePlayRecording {
    private var playCount: Int = 0

    
    public init() {}
    
    public func incrementPlayCount() {
        self.playCount += 1
    }
    
    public func record() {
        let gameRecord = GameRecord(date: .now, tries: playCount)
        saveRecords(gameRecord)
    }
    
    public func reset() {
        self.playCount = 0
    }
}

extension GamePlayRecorder {
    private func saveRecords(
        _ record: GameRecord
    ) {
        var currentRecords = loadRecords()
        currentRecords.append(record)
        
        do {
            let data = try JSONEncoder().encode(currentRecords)
            try data.write(
                to: URL(filePath: GameRecordFilePath.filePath)
            )
            print("기록이 저장되었습니다.")
        } catch {
            print("저장 실패 하였습니다 \(error.localizedDescription)")
        }
    }
    
    private func loadRecords() -> [GameRecord] {
        guard let data = try? Data(
            contentsOf: URL(filePath: GameRecordFilePath.filePath)
        ) else { return [] }
        return (try? JSONDecoder().decode([GameRecord].self, from: data)) ?? []
    }
}
