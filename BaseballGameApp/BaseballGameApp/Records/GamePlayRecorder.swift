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
    private let fileName = "game_records.json"
    
    private var filePath: String {
        let currentDirectory = FileManager.default.currentDirectoryPath
        return "\(currentDirectory)/\(fileName)"
    }
    
    public init() {}
    
    public func incrementPlayCount() {
        self.playCount += 1
    }
    
    public func record() {
        print("GamePlayRecorder: 실행하기 \(playCount)")
        let gameRecord = GameRecord(date: .now, tries: playCount)
        saveRecords(gameRecord)
    }
    
    public func reset() {
        self.playCount = 0
    }
}

extension GamePlayRecorder {
    private func saveRecords(_ record: GameRecord) {
        var records = loadRecords()
        records.append(record)
        
        do {
            let data = try JSONEncoder().encode(records)
            try data.write(to: URL(filePath: filePath))
            print("기록이 저장되었습니다.")
        } catch {
            print("저장 실패 하였습니다 \(error.localizedDescription)")
        }
    }
    
    private func loadRecords() -> [GameRecord] {
        guard let data = try? Data(contentsOf: URL(filePath: filePath)) else { return [] }
        return (try? JSONDecoder().decode([GameRecord].self, from: data)) ?? []
    }
}
