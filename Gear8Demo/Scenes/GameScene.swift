//
//  Copyright (c) 2015 Brandon Jenniges. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    let playButton: SKSpriteNode
    
    override init(size: CGSize) {
        playButton = SKSpriteNode(imageNamed: "play")
        super.init(size: size)
        
        backgroundColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        let background = SKSpriteNode(imageNamed: "title")
        background.position = CGPointMake(size.width / 2, size.height / 2)
        addChild(background)
        
        playButton.position = CGPointMake(size.width / 2, size.height / 2 - 150)
        addChild(playButton)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
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
