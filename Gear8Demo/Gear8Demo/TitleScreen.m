//
//  TitleScreen.m
//  Gear8Demo
//
//  Created by Brandon Jenniges on 2/16/14.
//  Copyright (c) 2014 Brandon Jenniges. All rights reserved.
//

#import "TitleScreen.h"
#import "Scene00.h"
#import "SKTUtils.h"

@import AVFoundation;

@implementation TitleScreen
{
    SKSpriteNode *_playButton;
    
    CGPoint _touchPoint;
}

#pragma mark -
#pragma mark Scene Setup and Initialize

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        self.backgroundColor = [SKColor colorWithRed:1.0  green:1.0 blue:1.0 alpha:1.0];
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"title"];
        background.anchorPoint = CGPointZero;
        background.position = CGPointZero;
        
        [self addChild:background];
        
        _playButton = [SKSpriteNode spriteNodeWithImageNamed:@"play"];
        _playButton.position = CGPointMake(CGRectGetMidX(self.frame),
                                                                  CGRectGetMidY(self.frame) - 150);
        [self addChild:_playButton];
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
        if([_playButton containsPoint:location])
        {
            Scene00 *scene = [[Scene00 alloc] initWithSize:self.size];
            SKTransition *sceneTransition = [SKTransition fadeWithColor:[UIColor lightGrayColor] duration:2];
            [self.view presentScene:scene transition:sceneTransition];
        }
        
    }
    
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    _touchPoint = [[touches anyObject] locationInNode:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

#pragma mark -
#pragma mark Game Loop

-(void)update:(CFTimeInterval)currentTime
{
        
}

@end

