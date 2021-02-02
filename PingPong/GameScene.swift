//
//  GameScene.swift
//  Lab_4
//
//  Created by Владислав Якубец on 28.12.2020.
//  Copyright © 2020 Владислав Якубец. All rights reserved.
//


import SpriteKit
import GameplayKit
import UIKit

class GameScene: SKScene {
    
    var score: [Int] = []
    var counter = 3
    var timer = Timer()
    var ball = SKSpriteNode()
    var main = SKSpriteNode()
    var enemy = SKSpriteNode()
    var counterLbl = SKLabelNode()
    var mainPointsLbl = SKLabelNode()
    var enemyPointsLbl = SKLabelNode()
    var backButton: SKLabelNode!
    var gameFinished = false
    var navigationController: UINavigationController!
    
    override func didMove(to view: SKView) {
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        main = self.childNode(withName: "main") as! SKSpriteNode
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        mainPointsLbl = self.childNode(withName: "mainPointsLbl") as! SKLabelNode
        enemyPointsLbl = self.childNode(withName: "enemyPointsLbl") as! SKLabelNode
        counterLbl = self.childNode(withName: "counterLbl") as! SKLabelNode
        
        counterLbl.isHidden = true
        
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1
        
        self.physicsBody = border
        startGame()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameFinished {
            for touch in touches {
                let location = touch.location(in: self)
                
                if currentGameType == .playerVsPlayer {
                    if location.y > 0 {
                        enemy.run(SKAction.moveTo(x: location.x, duration: 0.05))
                    } else if location.y < 0 {
                        main.run(SKAction.moveTo(x: location.x, duration: 0.05))
                    }
                } else {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.05))
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !gameFinished {
            for touch in touches {
                let location = touch.location(in: self)
                
                if currentGameType == .playerVsPlayer {
                    if location.y > 0 {
                        enemy.run(SKAction.moveTo(x: location.x, duration: 0.05))
                    } else if location.y < 0 {
                        main.run(SKAction.moveTo(x: location.x, duration: 0.05))
                    }
                } else {
                    main.run(SKAction.moveTo(x: location.x, duration: 0.05))
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            if gameFinished {
                if backButton.contains(location) {
                    navigationController.popViewController(animated: true)
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        switch currentGameType {
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.1))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.20))
            break
        case .playerVsPlayer:
            
            break
        case .none:
            break
        }
        
        if ball.position.y <= main.position.y - main.size.height {
            addScore(playerWhoWon: enemy)
        } else if ball.position.y >= enemy.position.y + enemy.size.height {
            addScore(playerWhoWon: main)
        }
    }
    
    func startGame() {
        score = [0, 0]
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        gameFinished = false
        
        self.run(SKAction.repeat(SKAction.sequence([SKAction.run { [self] in
            counterLbl.isHidden = false
            
            ball.isHidden = true
        
            counterLbl.text = "\(counter)"
            counter -= 1
        }, SKAction.wait(forDuration: 1)]), count: 3)) { [self] in
            ball.isHidden = false
            counterLbl.isHidden = true
            counter = 3
            ball.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 3))
        }
    }
    
    func stopGame(whoWin: SKSpriteNode) {
        ball.isHidden = true
        
        counterLbl.isHidden = true
        
        var message = ""
        if whoWin == main {
            message = "Выиграл! Поздравляю."
        } else if whoWin == enemy {
            message = "Ты проиграл("
        }
        
        let winLbl = SKLabelNode(text: message)
        
        self.addChild(winLbl)
        self.removeAllActions()
        
        winLbl.run(SKAction.fadeOut(withDuration: 2)) {
            self.backButton = SKLabelNode(text: "Вернуться в меню")
            self.backButton.fontColor = #colorLiteral(red: 1, green: 0.8112416587, blue: 0, alpha: 1)
            self.addChild(self.backButton)
            self.gameFinished = true
        }
    }
    
    func addScore(playerWhoWon: SKSpriteNode) {
        
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        
        if playerWhoWon == main {
            score[0] += 1
        } else if playerWhoWon == enemy {
            score[1] += 1
        }
        
        mainPointsLbl.text = "\(score[0])"
        enemyPointsLbl.text = "\(score[1])"
        
        self.run(SKAction.repeat(SKAction.sequence([SKAction.run { [self] in
            counterLbl.isHidden = false
            
            ball.isHidden = true
        
            counterLbl.text = "\(counter)"
            counter -= 1
            
        },
        SKAction.wait(forDuration: 1.0)]), count: 3)) { [self] in
            counterLbl.isHidden = true
            ball.isHidden = false
            
            counter = 3
            
            if playerWhoWon == main {
                ball.physicsBody?.applyImpulse(CGVector(dx: 3, dy: 3))
            } else if playerWhoWon == enemy {
                ball.physicsBody?.applyImpulse(CGVector(dx: -3, dy: -3))
            }
        }
        
        if score[0] >= 2 {
            stopGame(whoWin: main)
        } else if score[1] >= 2 {
            stopGame(whoWin: enemy)
        }
    }
}
