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
        print("GamePlayRecorder: 실행하기 \(playCount)")
    }
    
    public func reset() {
        self.playCount = 0
    }
}
