//
//  GameScene.swift
//  Gear8Demo
//
//  Created by Brandon Jenniges on 11/4/15.
//  Copyright (c) 2015 Brandon Jenniges. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let playButton: SKSpriteNode
    
    override init(size: CGSize) {
        playButton = SKSpriteNode(imageNamed: "play")
        super.init(size: size)
        
        self.backgroundColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        let background = SKSpriteNode(imageNamed: "title")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(background)
        
        playButton.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) - 150)
        self.addChild(playButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if self.playButton.containsPoint(location) {
                let scene = DragDropScene(size: self.size)
                let sceneTransition = SKTransition.fadeWithColor(UIColor.lightGrayColor(), duration: 2)
                self.view?.presentScene(scene, transition: sceneTransition)
            }
        }
    }
}
