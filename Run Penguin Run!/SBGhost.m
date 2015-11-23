//
//  SBGhost.m
//  Run Penguin Run!
//
//  Created by Stanley Delacruz on 8/5/14.
//  Copyright (c) 2014 Stanley Delacruz. All rights reserved.
//

#import "SBGhost.h"

@implementation SBGhost
- (instancetype)init
{
    if (self = [super init]) {
       
        [self spawnGhost];
    }
    return self;
}

- ( void)spawnGhost
{
    self.ghost = [SKSpriteNode spriteNodeWithImageNamed:@"monster_idle01@2x"];
    self.ghost.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:3];
    self.ghost.physicsBody.dynamic = NO;
    self.ghost.physicsBody.allowsRotation = NO;
    self.ghost.physicsBody.affectedByGravity = NO;
    [self.ghost runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"monster_idle01@2x"], [SKTexture textureWithImageNamed:@"monster_idle02@2x"]] timePerFrame:0.65]]];
    self.ghost.zPosition = 50;
    self.ghost.xScale = self.ghost.yScale = 0.8f;
    self.ghost.physicsBody.categoryBitMask = PCCategoryGhost;
    self.ghost.physicsBody.contactTestBitMask = PCCategoryPlayer;
    SKAction *ease = [SKAction repeatActionForever:[SKAction sequence:@[[SKAction scaleTo:0.7f duration:0.4],                                   [SKAction scaleTo:0.9f duration:0.4]]]];
    ease.timingMode = SKActionTimingLinear;
    [self.ghost runAction:ease];
    //self.ghost.name = @"ghost";
    SKAction *anotherTiming = [SKAction repeatActionForever:
                               [SKAction sequence:@[[SKAction moveByX:-10 y:-20 duration:1.1],
                                                    [SKAction moveByX:10 y:20 duration:1.1]]]];
    anotherTiming.timingMode = SKActionTimingEaseIn;
    [self.ghost runAction:anotherTiming];
    
   [self addChild:self.ghost];
    
    
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.ghost forKey:@"Ghost"];
    
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.ghost = [aDecoder decodeObjectForKey:@"Ghost"];
    }
    return  self;
}
@end
