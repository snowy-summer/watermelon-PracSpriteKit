//
//  GameScene.swift
//  watermelon
//
//  Created by 최승범 on 6/27/24.
//

import SpriteKit
import GameplayKit

final class GameScene: SKScene {
    
    private var gameModel = GameModel()
    private let scoreLabel = SKLabelNode(text: "0")
    private let nextBallImage = SKSpriteNode()
    
    override func sceneDidLoad() {
    
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        physicsWorld.contactDelegate = self
        
        configureBoundary()
        configureGameOverLine()
        configureScoreLabel()
        configureNextBallImage()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        makeFruit(what: gameModel.nextBall,
                  where: CGPoint(x: touchLocation.x,
                                 y: frame.height * 0.8))
        
        gameModel.randomBall()
        let newTexture = SKTexture(imageNamed: gameModel.nextBall.fileNamed)
        nextBallImage.texture = newTexture
    }
    
}

extension GameScene {
    
    private func configureBoundary() {
        
        let boundary = SKPhysicsBody(edgeLoopFrom: self.frame)
        boundary.categoryBitMask = PhysicsCategory.wall.bitmask
        boundary.collisionBitMask = PhysicsCategory.all.bitmask
        boundary.restitution = 0.3
        boundary.isDynamic = true
        
        self.physicsBody = boundary
    }
    
    private func configureScoreLabel() {
        
        scoreLabel.fontSize = 20
        scoreLabel.fontColor = .white
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: frame.width - 20,
                                 y: frame.height * 0.88)

        addChild(scoreLabel)
    }
    
    private func configureNextBallImage() {
        
        nextBallImage.position = CGPoint(x: 20,
                                         y: frame.height * 0.88)
        nextBallImage.size = CGSize(width: 30,
                                    height: 30)

        addChild(nextBallImage)
        
        let newTexture = SKTexture(imageNamed: gameModel.nextBall.fileNamed)
        nextBallImage.texture = newTexture
    }
    
    private func configureGameOverLine() {
        let line = SKShapeNode(rect: CGRect(x: 0,
                                            y: frame.height * 0.85,
                                            width: frame.width,
                                            height: 5))
        line.fillColor = .red
        
        addChild(line)
    
        line.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 0,
                                                              y: frame.height * 0.85,
                                                              width: frame.width,
                                                              height: 5))
        line.physicsBody?.affectedByGravity = false
        line.physicsBody?.categoryBitMask = PhysicsCategory.gameOverLine.bitmask
        line.physicsBody?.contactTestBitMask = PhysicsCategory.monsterBall.bitmask | PhysicsCategory.healBall.bitmask | PhysicsCategory.premierBall.bitmask | PhysicsCategory.heavyBall.bitmask | PhysicsCategory.diveBall.bitmask | PhysicsCategory.friendBall.bitmask | PhysicsCategory.hiperBall.bitmask | PhysicsCategory.luxuryBall.bitmask | PhysicsCategory.masterBall.bitmask | PhysicsCategory.superBall.bitmask
        
        line.physicsBody?.collisionBitMask = PhysicsCategory.none.bitmask
    }
    
    private func makeFruit(what type: PhysicsCategory,
                           where position: CGPoint) {
        
        let fruit = SKSpriteNode(imageNamed: type.fileNamed)
        fruit.size = CGSize(width: type.radius * 2,
                            height: type.radius * 2)
        
        
        fruit.position = position
        addChild(fruit)
        
        fruit.physicsBody = SKPhysicsBody(circleOfRadius: type.radius)
        
        fruit.physicsBody?.categoryBitMask = type.bitmask
        fruit.physicsBody?.contactTestBitMask = type.bitmask | PhysicsCategory.gameOverLine.bitmask
        fruit.physicsBody?.collisionBitMask = PhysicsCategory.all.bitmask
        fruit.physicsBody?.restitution = 0.3
        fruit.physicsBody?.isDynamic = true
    }
    
    private func merge(what type: PhysicsCategory,
                       where position: CGPoint) {
        
        makeFruit(what: type,
                  where: position)
        gameModel.score += type.mergeScore
        
    }
    
    private func murgeResultOfFruit(_ bitmask: UInt32) -> PhysicsCategory {
        switch bitmask {
        case PhysicsCategory.monsterBall.bitmask:
            return .healBall
        case PhysicsCategory.healBall.bitmask:
            return .heavyBall
        case PhysicsCategory.heavyBall.bitmask:
            return .superBall
        case PhysicsCategory.superBall.bitmask:
            return .premierBall
        case PhysicsCategory.premierBall.bitmask:
            return .friendBall
        case PhysicsCategory.friendBall.bitmask:
            return .luxuryBall
        case PhysicsCategory.luxuryBall.bitmask:
            return .diveBall
        case PhysicsCategory.diveBall.bitmask:
            return .hiperBall
        case PhysicsCategory.hiperBall.bitmask:
            return .masterBall
        default:
            return .none
        }
    }
    
}

extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == secondBody.categoryBitMask  {
            
            if let position = secondBody.node?.position {
                firstBody.node?.removeFromParent()
                secondBody.node?.removeFromParent()
                
                let fruit = murgeResultOfFruit(firstBody.categoryBitMask)
                
                merge(what: fruit, where: position)
                scoreLabel.text = String(gameModel.score)
            }
        }
        
        if secondBody.categoryBitMask == PhysicsCategory.gameOverLine.bitmask {
            
            let gameOverScene = GameOverScene(size: self.size,
                                              score: gameModel.score)
            
            view?.presentScene(gameOverScene)
            
        }
        
    }
    
}
