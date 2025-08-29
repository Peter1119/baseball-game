//
//  GameRecordFilePath.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/29/25.
//

import Foundation

public enum GameRecordFilePath {
    static private let fileName = "game_records.json"
    
    static var filePath: String {
        let currentDirectory = FileManager.default.currentDirectoryPath
        return "\(currentDirectory)/\(Self.fileName)"
    }
}
