//
//  DragDropScene.swift
//  Gear8Demo
//
//  Created by Brandon Jenniges on 11/4/15.
//  Copyright © 2015 Brandon Jenniges. All rights reserved.
//

import SpriteKit

class DragDropScene: SKScene {

    var footer: SKSpriteNode!
    
    let paper = MoveableObject(image: "paper", blankImage: "silhouette_paper")
    let circle = MoveableObject(image: "circle", blankImage: "silhouette_circle")
    let square = MoveableObject(image: "square", blankImage: "silhouette_square")
    let triangle = MoveableObject(image: "triangle", blankImage: "silhouette_triangle")
    
    var touchPoint: CGPoint!
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = SKColor(red: 1, green: 1, blue: 1, alpha: 1)
        
        let background = SKSpriteNode(imageNamed:"background_1_blank")
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        self.addChild(background)
        
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.text = "Gear 8 Demo!"
        label.fontSize = 30
        label.position = CGPointMake(CGRectGetMidX(self.frame),
            CGRectGetHeight(self.frame) - 100)
        
        setupFooter()
        setupBlankImages()
        setupMoveableImages()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupFooter() {
        footer = SKSpriteNode(imageNamed: "footer")
        footer.position = CGPointMake(CGRectGetMidX(self.frame), 38)
        addChild(footer)
        physicsBody = SKPhysicsBody(edgeLoopFromRect: footer.frame)
    }
    
    func setupBlankImages() {
        paper.blank.position = CGPointMake(CGRectGetMidX(self.frame) + 140, CGRectGetMidY(self.frame) + 175)
        self.addChild(paper.blank)
        
        circle.blank.position = CGPointMake(paper.blank.position.x + 200, paper.blank.position.y)
        self.addChild(circle.blank)
        
        triangle.blank.position = CGPointMake(paper.blank.position.x, CGRectGetMidY(self.frame) + 25)
        self.addChild(triangle.blank)
        
        square.blank.position = CGPointMake(circle.blank.position.x, triangle.blank.position.y)
        self.addChild(square.blank)
    }
    
    func setupMoveableImages() {
        paper.sprite.position = CGPointMake(self.frame.width / 4, 100)
        setupMoveableObject(paper.sprite)
        
        circle.sprite.position = CGPointMake(self.frame.width / 3, 100)
        setupMoveableObject(circle.sprite)
        
        triangle.sprite.position = CGPointMake(self.frame.width / 2, 100)
        setupMoveableObject(triangle.sprite)
        
        square.sprite.position = CGPointMake(self.frame.width / 1.5, 100)
        setupMoveableObject(square.sprite)
    }
    
    func setupMoveableObject(object: SKSpriteNode) {
        object.physicsBody = SKPhysicsBody(rectangleOfSize: object.size)
        object.physicsBody?.restitution = 0.5
        addChild(object)
    }
    
    //MARK : Touches
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            let location = touch.locationInNode(self)
            if paper.sprite.containsPoint(location) {
                handleObjectTouch(paper, location: location)
            } else if circle.sprite.containsPoint(location) {
                handleObjectTouch(circle, location: location)
            } else if triangle.sprite.containsPoint(location) {
                handleObjectTouch(triangle, location: location)
            } else if square.sprite.containsPoint(location) {
                handleObjectTouch(square, location: location)
            }
        }
    }
    
    func handleObjectTouch(object:MoveableObject, location:CGPoint) {
        touchPoint = location
        object.isBeingTouched = true
        object.sprite.physicsBody?.velocity = CGVectorMake(0, 0)
        object.sprite.physicsBody?.angularVelocity = 0
        object.sprite.physicsBody?.affectedByGravity = false
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        touchPoint = touches.first?.locationInNode(self)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if paper.isBeingTouched {
            checkIfTouchCompleted(paper, touches: touches)
        } else if circle.isBeingTouched {
            checkIfTouchCompleted(circle, touches: touches)
        } else if triangle.isBeingTouched {
            checkIfTouchCompleted(triangle, touches: touches)
        } else if square.isBeingTouched {
            checkIfTouchCompleted(square, touches: touches)
        }
    }
    
    func checkIfTouchCompleted(object:MoveableObject, touches: Set<UITouch>) {
        if let currentPoint = touches.first?.locationInNode(self) {
            if currentPoint.x >= object.blank.frame.origin.x && currentPoint.x <= object.blank.frame.origin.x + object.blank.size.width && currentPoint.y >= object.blank.frame.origin.y && currentPoint.y <= object.blank.frame.origin.x + object.blank.size.height {
                object.sprite.position = object.blank.position
                object.isDone = true
            } else {
                object.sprite.physicsBody?.affectedByGravity = true
                object.isDone = false
            }
            object.isBeingTouched  = false
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
        if paper.isBeingTouched {
            moveObject(paper)
        } else if circle.isBeingTouched {
            moveObject(circle)
        } else if triangle.isBeingTouched {
            moveObject(triangle)
        } else if square.isBeingTouched {
            moveObject(square)
        }
        
        if(paper.isDone && circle.isDone && triangle.isDone && square.isDone) {
            let scene = PaintScene(size: self.size)
            let sceneTransition = SKTransition.fadeWithColor(UIColor.lightGrayColor(), duration: 2)
            self.view?.presentScene(scene, transition: sceneTransition)
        }
    }
    
    func moveObject(object:MoveableObject) {
        touchPoint.x.clamp(object.sprite.size.width / 2,  self.size.width - object.sprite.size.width / 2)
        
        touchPoint.y.clamp(footer.size.height + object.sprite
        .size.height / 2, self.size.height - object.sprite.size.height / 2)
        object.sprite.position = touchPoint
    }
}
