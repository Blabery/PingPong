//
//  GameViewController.swift
//  Lab_4
//
//  Created by Владислав Якубец on 28.12.2020.
//  Copyright © 2020 Владислав Якубец. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

var currentGameType: GameType!

class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene{
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                scene.size = view.frame.size
                scene.navigationController = navigationController
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
