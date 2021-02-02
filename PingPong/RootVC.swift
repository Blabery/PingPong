//
//  RootVC.swift
//  Lab_4
//
//  Created by Владислав Якубец on 29.12.2020.
//  Copyright © 2020 Владислав Якубец. All rights reserved.
//

import UIKit

class RootVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func playerVPlayer(_ sender: Any) {
        play(type: .playerVsPlayer)
    }
    @IBAction func easy(_ sender: Any) {
        play(type: .easy)
    }
    @IBAction func medium(_ sender: Any) {
        play(type: .medium)
    }
    @IBAction func hard(_ sender: Any) {
        play(type: .hard)
    }
    
    @IBAction func info(_ sender: Any) {
        let destinationVC = storyboard?.instantiateViewController(identifier: "InfoViewController")
        present(destinationVC!, animated: true, completion: nil)
    }
    
    func play(type: GameType) {
        let destinationVC = storyboard?.instantiateViewController(identifier: "GameViewController") as! GameViewController
        currentGameType = type
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}

enum GameType {
    case playerVsPlayer
    case easy
    case medium
    case hard
}
