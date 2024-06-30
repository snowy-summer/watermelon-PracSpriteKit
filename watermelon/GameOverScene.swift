//
//  GameOverScene.swift
//  watermelon
//
//  Created by 최승범 on 6/30/24.
//

import SpriteKit

final class GameOverScene: SKScene {
    
    private let score: Int
    
    init(size: CGSize, score: Int) {
        self.score = score
        super.init(size: size)
        
        backgroundColor = SKColor.white
        
    }
    
    override func sceneDidLoad() {
        
        let message = "점수: \(score)"
        
        let label = SKLabelNode()
        label.text = message
        label.fontSize = 40
        label.fontColor = SKColor.black
        label.position = CGPoint(x: size.width / 2,
                                 y: size.height / 2)
        addChild(label)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
