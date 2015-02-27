//
//  Scene01.m
//  TheSeasons
//
//  Created by Tammy Coron on 9/13/13.
//  Copyright (c) 2013 Tammy Coron. All rights reserved.
//

#import "TitleScreen.h"
#import "Scene01.h"
#import "Scene00.h"
#import "SKTUtils.h"
@import AVFoundation;

@interface Scene01 ()


@end

@implementation Scene01
{
    SKSpriteNode *_bird;
    BOOL _touchingBird;
    
    CGPoint _touchPoint;
}

#pragma mark -
#pragma mark Scene Setup and Initialize

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor colorWithRed:1.0  green:1.0 blue:1.0 alpha:1.0];
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"background_2"];
        background.anchorPoint = CGPointZero;
        background.position = CGPointZero;
        
        [self addChild:background];
        
        [self setUpMainCharacter];
    }
    return self;
}

- (void)willMoveFromView:(SKView *)view
{
    
}

#pragma mark -
#pragma mark Standard Scene Setup

- (void)setUpText
{
}

- (void)readText
{
  
}

- (void)setUpFooter
{
  
}

#pragma mark -
#pragma mark Additional Scene Setup (sprites and such)

- (void)setUpMainScene
{
}

- (void)setUpMainCharacter
{
    _bird = [SKSpriteNode spriteNodeWithImageNamed:@"flying_owl_0"];
    _bird.position = CGPointMake(_bird.size.width/2 + 20, self.frame.size.height - 170);
   // _bird.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_bird.size];
   // _bird.physicsBody.restitution = 0.5;
    
    [self addChild:_bird];
}

- (void)setUpMainCharacterAnimation
{
}

- (void)setUpHat
{
}

#pragma mark -
#pragma mark Code For Sound & Ambiance

- (void)playBackgroundMusic:(NSString *)filename
{
    
}

- (void)showSoundButtonForTogglePosition:(BOOL )togglePosition
{
    // NSLog(@"togglePosition: %i", togglePosition);
    
}

#pragma mark -
#pragma mark Touch Events

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches)
    {
        CGPoint location = [touch locationInNode:self];
        
        if([_bird containsPoint:location])
        {
            _touchingBird = YES;
            _touchPoint = location;
            
            _bird.physicsBody.velocity = CGVectorMake(0, 0);
            _bird.physicsBody.angularVelocity = 0;
            _bird.physicsBody.affectedByGravity = NO;
        }
    }

    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
        _touchPoint = [[touches anyObject] locationInNode:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_touchingBird)
    {
        CGPoint currentPoint = [[touches anyObject] locationInNode:self];
        
        if(currentPoint.x > self.frame.size.width - _bird.size.width/2 - 20){
            currentPoint.x = self.frame.size.width - _bird.size.width/2 - 20;
        }
        
        if(currentPoint.x <  _bird.size.width/2 + 20) {
            currentPoint.x = _bird.size.width/2 + 20;
        }
        
        _bird.position = CGPointMake(currentPoint.x, _bird.position.y);
        
        _touchingBird = NO;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
 }

#pragma mark -
#pragma mark Game Loop

-(void)update:(CFTimeInterval)currentTime
{
    if (_touchingBird)
    {
        _touchPoint.x = Clamp(_touchPoint.x, _bird.size.width/2 + 20, self.frame.size.width - _bird.size.width/2 - 20);
        _touchPoint.y = _bird.position.y;
        
        _bird.position = _touchPoint;
        
        if(_bird.position.x >= self.frame.size.width * 0.60f){
            _bird.texture = [SKTexture textureWithImageNamed:@"flying_owl_3"];
        } else if(_bird.position.x >= self.frame.size.width * 0.45f){
            _bird.texture = [SKTexture textureWithImageNamed:@"flying_owl_2"];
        } else if(_bird.position.x >= self.frame.size.width * 0.30f){
            _bird.texture = [SKTexture textureWithImageNamed:@"flying_owl_1"];
        } else {
            _bird.texture = [SKTexture textureWithImageNamed:@"flying_owl_0"];
        }
        
       
    }
}

@end
