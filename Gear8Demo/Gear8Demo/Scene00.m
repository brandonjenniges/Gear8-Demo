//
//  Scene00.m
//  TheSeasons
//
//  Created by Tammy Coron on 9/15/13.
//  Copyright (c) 2013 Tammy Coron. All rights reserved.
//

#import "Scene00.h"
#import "Scene01.h"
#import "SKTUtils.h"

@import AVFoundation;

@implementation Scene00
{
    SKSpriteNode *_footer;
    
    SKSpriteNode *_paper;
    SKSpriteNode *_circle;
    SKSpriteNode *_triangle;
    SKSpriteNode *_square;
    
    SKSpriteNode *_paper_blank;
    SKSpriteNode *_circle_blank;
    SKSpriteNode *_triangle_blank;
    SKSpriteNode *_square_blank;
    
    BOOL _touchingPaper;
    BOOL _touchingCircle;
    BOOL _touchingTriangle;
    BOOL _touchingSquare;
    
    BOOL _paperDone;
    BOOL _circleDone;
    BOOL _triangleDone;
    BOOL _squareDone;
    
    CGPoint _touchPoint;
}

#pragma mark -
#pragma mark Scene Setup and Initialize

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor colorWithRed:1.0  green:1.0 blue:1.0 alpha:1.0];

        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_1_blank"];
        background.anchorPoint = CGPointZero;
        background.position = CGPointZero;
        
        [self addChild:background];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Gear 8 Demo!";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetHeight(self.frame) - 100.0f);
        
        
        [self setUpFooter];
        [self setUpBlankImages];
        [self setUpMoveableImages];
    }
    
    return self;
}

- (void)willMoveFromView:(SKView *)view
{
    
}

#pragma mark -
#pragma mark Additional Scene Setup (sprites and such)

- (void)setUpBookTitle
{
    
}

- (void)setUpFooter
{
    _footer = [SKSpriteNode spriteNodeWithImageNamed:@"footer"];
    _footer.position = CGPointMake(self.size.width/2, 38);
    
    [self addChild:_footer];
    
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:_footer.frame];
}

- (void)setUpBlankImages
{
    // Paper
    [_paper_blank removeFromParent];
    
    _paper_blank = [SKSpriteNode spriteNodeWithImageNamed:@"silhouette_paper"];
    _paper_blank.position = CGPointMake(650, 550);
    
    [self addChild:_paper_blank];
    
    // Circle
    [_circle_blank removeFromParent];
    
    _circle_blank = [SKSpriteNode spriteNodeWithImageNamed:@"silhouette_circle"];
    _circle_blank.position = CGPointMake(850, 550);
    
    [self addChild:_circle_blank];
    
    // Triangle
    [_triangle_blank removeFromParent];
    
    _triangle_blank = [SKSpriteNode spriteNodeWithImageNamed:@"silhouette_triangle"];
    _triangle_blank.position = CGPointMake(650, 400);
    
    [self addChild:_triangle_blank];
    
    // Square
    [_square_blank removeFromParent];
    
    _square_blank = [SKSpriteNode spriteNodeWithImageNamed:@"silhouette_square"];
    _square_blank.position = CGPointMake(850, 420);
    
    [self addChild:_square_blank];
}

- (void)setUpMoveableImages
{
    [_paper removeFromParent];
    [_circle removeFromParent];
    [_triangle removeFromParent];
    [_square removeFromParent];
    
    
    // Paper
    _paper = [SKSpriteNode spriteNodeWithImageNamed:@"paper"];
    _paper.position = CGPointMake(900, 100);
    _paper.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_paper.size];
    _paper.physicsBody.restitution = 0.5;
    
    // Circle
    _circle = [SKSpriteNode spriteNodeWithImageNamed:@"circle"];
    _circle.position = CGPointMake(600, 100);
    _circle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_circle.size];
    _circle.physicsBody.restitution = 0.5;
    
    // Triangle
    _triangle = [SKSpriteNode spriteNodeWithImageNamed:@"triangle"];
    _triangle.position = CGPointMake(800, 100);
    _triangle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_triangle.size];
    _triangle.physicsBody.restitution = 0.5;
    
    // Square
    _square = [SKSpriteNode spriteNodeWithImageNamed:@"square"];
    _square.position = CGPointMake(700, 100);
    _square.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_square.size];
    _square.physicsBody.restitution = 0.5;
    
    // Attach
    [self addChild:_paper];
    [self addChild:_circle];
    [self addChild:_triangle];
    [self addChild:_square];
}

#pragma mark -
#pragma mark Code For Sound & Ambiance

- (void)playBackgroundMusic:(NSString *)filename
{

}

- (void)showSoundButtonForTogglePosition:(BOOL )togglePosition
{

}

#pragma mark -
#pragma mark Touch Events

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        
        if([_paper containsPoint:location])
        {
            _touchingPaper = YES;
            _touchPoint = location;
            
            _paper.physicsBody.velocity = CGVectorMake(0, 0);
            _paper.physicsBody.angularVelocity = 0;
            _paper.physicsBody.affectedByGravity = NO;
        }
        
        else if([_circle containsPoint:location])
        {            _touchingCircle = YES;
            _touchPoint = location;
            
            _circle.physicsBody.velocity = CGVectorMake(0, 0);
            _circle.physicsBody.angularVelocity = 0;
            _circle.physicsBody.affectedByGravity = NO;
        }
        
        else if([_triangle containsPoint:location])
        {
            _touchingTriangle = YES;
            _touchPoint = location;
            
            
            _triangle.physicsBody.velocity = CGVectorMake(0, 0);
            _triangle.physicsBody.angularVelocity = 0;
            _triangle.physicsBody.affectedByGravity = NO;
        }
        
        else if([_square containsPoint:location])
        {
            _touchingSquare = YES;
            _touchPoint = location;
            
            _square.physicsBody.velocity = CGVectorMake(0, 0);
            _square.physicsBody.angularVelocity = 0;
            _square.physicsBody.affectedByGravity = NO;
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchPoint = [[touches anyObject] locationInNode:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_touchingPaper)
    {
        CGPoint currentPoint = [[touches anyObject] locationInNode:self];
        
        if ( currentPoint.x >= _paper_blank.frame.origin.x && currentPoint.x <= _paper_blank.frame.origin.x + _paper_blank.size.width &&
            currentPoint.y >= _paper_blank.frame.origin.y && currentPoint.y <= _paper_blank.frame.origin.x + _paper_blank.size.height )
        {
            _paper.position = _paper_blank.position;
            _paperDone = YES;
    
        }
        else
        {
            _paper.physicsBody.affectedByGravity = YES;
            _paperDone = NO;
        }
        
        _touchingPaper = NO;
    }
    
    else if (_touchingCircle)
    {
        CGPoint currentPoint = [[touches anyObject] locationInNode:self];
        
        if ( currentPoint.x >= _circle_blank.frame.origin.x && currentPoint.x <= _circle_blank.frame.origin.x + _circle_blank.size.width &&
            currentPoint.y >= _circle_blank.frame.origin.y && currentPoint.y <= _circle_blank.frame.origin.x + _circle_blank.size.height )
        {
            _circle.position = _circle_blank.position;
             _circleDone = YES;
        }
        else
        {
            _circle.physicsBody.affectedByGravity = YES;
            _circleDone = NO;
        }
        
        _touchingCircle = NO;
    }
    
    else if (_touchingTriangle)
    {
        CGPoint currentPoint = [[touches anyObject] locationInNode:self];
        
        if ( currentPoint.x >= _triangle_blank.frame.origin.x && currentPoint.x <= _triangle_blank.frame.origin.x + _triangle_blank.size.width &&
            currentPoint.y >= _triangle_blank.frame.origin.y && currentPoint.y <= _triangle_blank.frame.origin.x + _triangle_blank.size.height )
        {
            _triangle.position = _triangle_blank.position;
            _triangleDone = YES;
            
        }
        else
        {
            _triangle.physicsBody.affectedByGravity = YES;
            _triangleDone = NO;
        }
        
        _touchingTriangle = NO;
    }
    
    else if (_touchingSquare)
    {
        CGPoint currentPoint = [[touches anyObject] locationInNode:self];
        
        if ( currentPoint.x >= _square_blank.frame.origin.x && currentPoint.x <= _square_blank.frame.origin.x + _square_blank.size.width &&
            currentPoint.y >= _square_blank.frame.origin.y && currentPoint.y <= _square_blank.frame.origin.x + _square_blank.size.height )
        {
            _square.position = _square_blank.position;
            _squareDone = YES;
            
        }
        else
        {
            _square.physicsBody.affectedByGravity = YES;
            _squareDone = NO;
        }
        
        _touchingSquare = NO;
    }
    
    if(_paperDone && _circleDone && _triangleDone && _squareDone)
    {
        Scene01 *scene = [[Scene01 alloc] initWithSize:self.size];
        SKTransition *sceneTransition = [SKTransition fadeWithColor:[UIColor lightGrayColor] duration:2];
        [self.view presentScene:scene transition:sceneTransition];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark -
#pragma mark Game Loop

-(void)update:(CFTimeInterval)currentTime
{
    if (_touchingPaper)
    {
        _touchPoint.x = Clamp(_touchPoint.x, _paper.size.width / 2, self.size.width - _paper.size.width / 2);
        _touchPoint.y = Clamp(_touchPoint.y,
                              _footer.size.height +  _paper.size.height / 2,
                              self.size.height - _paper.size.height / 2);
        
        _paper.position = _touchPoint;
    }
    
    else if (_touchingCircle)
    {
        _touchPoint.x = Clamp(_touchPoint.x, _circle.size.width / 2, self.size.width - _circle.size.width / 2);
        _touchPoint.y = Clamp(_touchPoint.y,
                              _footer.size.height +  _circle.size.height / 2,
                              self.size.height - _circle.size.height / 2);
        
        _circle.position = _touchPoint;
    }
    
    else if (_touchingTriangle)
    {
        _touchPoint.x = Clamp(_touchPoint.x, _triangle.size.width / 2, self.size.width - _triangle.size.width / 2);
        _touchPoint.y = Clamp(_touchPoint.y,
                              _footer.size.height +  _triangle.size.height / 2,
                              self.size.height - _triangle.size.height / 2);
        
        _triangle.position = _touchPoint;
    }
    
    else if (_touchingSquare)
    {
        _touchPoint.x = Clamp(_touchPoint.x, _square.size.width / 2, self.size.width - _square.size.width / 2);
        _touchPoint.y = Clamp(_touchPoint.y,
                              _footer.size.height +  _square.size.height / 2,
                              self.size.height - _square.size.height / 2);
        
        _square.position = _touchPoint;
    }
}

@end
