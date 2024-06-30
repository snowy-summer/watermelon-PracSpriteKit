//
//  PhysicsCategory.swift
//  watermelon
//
//  Created by 최승범 on 6/29/24.
//

import Foundation

enum PhysicsCategory: CaseIterable {
    case none
    case all
    case monsterBall
    case healBall
    case heavyBall
    case superBall
    case premierBall
    case friendBall
    case luxuryBall
    case diveBall
    case hiperBall
    case masterBall
    case gameOverLine
    case wall
    
    var bitmask: UInt32 {
        switch self {
        case .none:
            return 0
        case .monsterBall:
            return 1 << 0
        case .healBall:
            return 1 << 1
        case .heavyBall:
            return 1 << 2
        case .superBall:
            return 1 << 3
        case .premierBall:
            return 1 << 4
        case .friendBall:
            return 1 << 5
        case .luxuryBall:
            return 1 << 6
        case .diveBall:
            return 1 << 7
        case .hiperBall:
            return 1 << 8
        case .masterBall:
            return 1 << 9
        case .gameOverLine:
            return 1 << 11
        case .wall:
            return 1 << 14
        case .all:
            return UInt32.max
        }
    }
    
    var radius: CGFloat {
        switch self {
        case .none:
            return 0
        case .all:
            return 0
        case .monsterBall:
            return 20
        case .healBall:
            return 30
        case .heavyBall:
            return 40
        case .superBall:
            return 50
        case .premierBall:
            return 60
        case .friendBall:
            return 70
        case .luxuryBall:
            return 80
        case .diveBall:
            return 90
        case .hiperBall:
            return 100
        case .masterBall:
            return 110
        case .gameOverLine:
            return 0
        case .wall:
            return 0
        }
    }
    
    var mergeScore: Int {
        switch self {
            
        case .healBall:
            return 1
        case .heavyBall:
            return 3
        case .superBall:
            return 6
        case .premierBall:
            return 10
        case .friendBall:
            return 15
        case .luxuryBall:
            return 21
        case .diveBall:
            return 45
        case .hiperBall:
            return 55
        case .masterBall:
            return 100
        default:
            return 0
        }
    }
    
    var fileNamed: String {
        switch self {
        case .monsterBall:
            return "monsterBall"
        case .healBall:
            return "healBall"
        case .heavyBall:
            return "heavyBall"
        case .superBall:
            return "superBall"
        case .premierBall:
            return "premierBall"
        case .friendBall:
            return "friendBall"
        case .luxuryBall:
            return "luxuryBall"
        case .diveBall:
            return "diveBall"
        case .hiperBall:
            return "hiperBall"
        case .masterBall:
            return "masterBall"
        default:
            return ""
        }
    }
}
