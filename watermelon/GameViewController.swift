//
//  GameViewController.swift
//  watermelon
//
//  Created by 최승범 on 6/27/24.
//

import UIKit
import SpriteKit
import SnapKit

final class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size)
        let skView = SKView()
        view.addSubview(skView)
        
        skView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
        
    }
}
