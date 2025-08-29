//
//  GamePlayRecorder.swift
//  BaseballGameApp
//
//  Created by 홍석현 on 8/29/25.
//

import Foundation

public protocol GamePlayRecording {
    func execute(_ playCount: Int)
}

public struct GamePlayRecorder: GamePlayRecording {
    public init() {}
    
    public func execute(_ playCount: Int) {
        print("GamePlayRecorder: 실행하기 \(playCount)")
    }
}
