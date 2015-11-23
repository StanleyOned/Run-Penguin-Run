//
//  SBPlayer.h
//  Run Penguin Run!
//
//  Created by Stanley Delacruz on 7/29/14.
//  Copyright (c) 2014 Stanley Delacruz. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SBPlayer : SKSpriteNode
@property (assign, nonatomic) BOOL jump;
@property (strong,nonatomic)NSMutableArray *walk;
@property (strong,nonatomic)NSMutableArray *jumping;
@property (assign,nonatomic)enum playerState animationState;
- (void)startWalkingAnimation;

typedef enum  playerState{
    playerStateRunning = 0,
    playerStateJumping,
    playerStateInAir
} playerState;
@end
