//
//  SBPlayer.m
//  Run Penguin Run!
//
//  Created by Stanley Delacruz on 7/29/14.
//  Copyright (c) 2014 Stanley Delacruz. All rights reserved.
//

#import "SBPlayer.h"
#import "SKNode+SKTExtras.h"
#import "SKAction+SKTExtras.h"
#import "SKEmitterNode+SKTExtras.h"
@implementation SBPlayer


- (instancetype)init
{
    self = [super initWithImageNamed:@"walk00@2x.png"];
    {
    self.name = playerName;
        self.zPosition = 10;
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(self.size.width, self.size.height)];
        self.physicsBody.dynamic = YES;
        self.physicsBody.allowsRotation = NO;
        self.physicsBody.mass = playerMass;
        self.physicsBody.collisionBitMask = PCCategoryBackground | PCCategorySlug;
        self.physicsBody.restitution = 0;
        self.physicsBody.categoryBitMask = PCCategoryPlayer;
        self.physicsBody.contactTestBitMask = PCCategorySlug;
        
        self.xScale = self.yScale = 0.9f;
        [self setupAnimations];
        [self startWalkingAnimation];
        self.physicsBody.linearDamping = 0.8;
        
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.walk forKey:@"Walk"];
    [aCoder encodeBool:self.jump forKey:@"Jump"];
    [aCoder encodeObject:self.jumping forKey:@"Jumping"];
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.walk = [aDecoder decodeObjectForKey:@"Walk"];
        self.jump = [aDecoder decodeBoolForKey:@"Jump"];
        self.jumping = [aDecoder decodeObjectForKey:@"Jumping"];
    }
    return self;
}
- (void)setupAnimations
{
    self.walk = [[NSMutableArray alloc]init];
    SKTextureAtlas *walkAtlas = [SKTextureAtlas atlasNamed:@"walk"];
    
    for (int i = 0; i < [walkAtlas.textureNames count]; i++) {
        NSString *textures = [NSString stringWithFormat:@"walk%.2d", i];
        SKTexture *tempTextures = [walkAtlas textureNamed:textures];
        if (tempTextures) {
            [self.walk addObject:tempTextures];
        }
    }
    self.jumping = [[NSMutableArray alloc]init];
    SKTextureAtlas *jumpingAtlas = [SKTextureAtlas atlasNamed:@"jump"];
    
    for (int i = 1; i < [jumpingAtlas.textureNames count]; i++) {
        NSString *textures = [NSString stringWithFormat:@"jump%.2d",i];
        SKTexture *tempTextures = [jumpingAtlas textureNamed:textures];
        if (tempTextures) {
            [self.jumping addObject:tempTextures];
        }
    }
}
- (void)startWalkingAnimation
{
    if (![self actionForKey:@"walking"]) {
        [self runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:self.walk timePerFrame:0.09 resize:YES  restore:NO]] withKey:@"walking"];
    }
 
}
- (void) stopWalkingAnimation
{
    [self removeActionForKey:@"walking"];
}
- (void)startJumpingAnimation
{
    
    if (![self actionForKey:@"jumping"]) {
        [self runAction:[SKAction sequence:@[[SKAction animateWithTextures:self.jumping timePerFrame:0.10 resize:YES restore:NO],
        ]]withKey:@"jumping"];
        self.animationState = playerStateInAir;
    }
}
- (void)setAnimationState:(playerState)animationState
{
    switch (animationState) {
        case playerStateJumping:
            if (_animationState == playerStateRunning) {
                [self stopWalkingAnimation];
                [self startJumpingAnimation];
            }
            break;
            case playerStateInAir:
            [self stopWalkingAnimation];
            break;
            case playerStateRunning:
            [self startWalkingAnimation];
            break;
            
        default:
            break;
    }
    _animationState = animationState;
}

@end
