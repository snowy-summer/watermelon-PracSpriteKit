//
//  GameModel.swift
//  watermelon
//
//  Created by 최승범 on 6/29/24.
//

import Foundation

struct GameModel {
    var score = 0

    let ballList: [PhysicsCategory] = [
        .monsterBall,
        .healBall,
        .heavyBall
    ]
    
    var nextBall: PhysicsCategory  = .monsterBall
    
    mutating func randomBall() {
        nextBall = ballList.randomElement()!
    }
    
}
