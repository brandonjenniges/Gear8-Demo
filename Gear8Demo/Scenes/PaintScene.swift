//
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import SpriteKit

class PaintScene: SKScene {
    
    let bird = SKSpriteNode(imageNamed: "flying_owl_0")
    var touchingBird = false
    
    var touchPoint: CGPoint!
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
        let background = SKSpriteNode(imageNamed:"background_2")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(background)
        
        setupBird()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupBird() {
        bird.position = CGPointMake(bird.size.width / 2 + 20, self.frame.size.height - 170)
        self.addChild(bird)
    }
    
    //MARK : Touches
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if bird.containsPoint(location) {
                touchingBird = true
                touchPoint = location
                
                bird.physicsBody?.velocity = CGVector.zero
                bird.physicsBody?.angularVelocity = 0
                bird.physicsBody?.affectedByGravity = false
            }
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchPoint = touches.first?.locationInNode(self)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if touchingBird {
            //TODO: Fix
            if var currentPoint = touches.first?.locationInNode(self) {
                if currentPoint.x > self.frame.size.width - bird.size.width / 2 - 20 {
                    currentPoint.x = self.frame.size.width - bird.size.width / 2 - 20
                }
                if currentPoint.x < bird.size.width / 2 + 20 {
                    currentPoint.x = bird.size.width / 2 + 20
                }
                
                bird.position = CGPointMake(currentPoint.x, bird.position.y)
                touchingBird = false
            }
        }
    }
    
    //MARK : Update
    override func update(currentTime: NSTimeInterval) {
        if touchingBird {
            touchPoint.x.clamp(bird.size.width / 2 + 20, self.frame.size.width - bird.size.width / 2 - 20)
            touchPoint.y = bird.position.y
            
            bird.position = touchPoint
            
            if bird.position.x >= self.frame.size.width * 0.6 {
                bird.texture = SKTexture(imageNamed: "flying_owl_3")
            } else if bird.position.x >= self.frame.size.width * 0.45 {
                bird.texture = SKTexture(imageNamed: "flying_owl_2")
            } else if bird.position.x >= self.frame.size.width * 0.3 {
                bird.texture = SKTexture(imageNamed: "flying_owl_1")
            } else {
                bird.texture = SKTexture(imageNamed: "flying_owl_0")
            }
        }
    }
    
}
