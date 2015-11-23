//
//  SBCoins.m
//  Run Penguin Run!
//
//  Created by Stanley Delacruz on 9/1/14.
//  Copyright (c) 2014 Stanley Delacruz. All rights reserved.
//

#import "SBCoins.h"

@implementation SBCoins

-(id)init
{
    if (self = [super init]) {
         self.coins = [SKSpriteNode spriteNodeWithImageNamed:@"Coin00@2x"];
        self.coins.name = @"coins";
        self.coins.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:3];
        self.coins.physicsBody.contactTestBitMask = PCCategoryPlayer;
        self.coins.physicsBody.allowsRotation = NO;
        self.coins.physicsBody.dynamic = NO;
        self.coins.physicsBody.affectedByGravity = NO;
        self.coins.zPosition = 50;
        self.coins.xScale = self.coins.yScale = 0.5f;
        self.coins.physicsBody.categoryBitMask = PCCategoryCoin;
        [self.coins runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[
            [SKTexture textureWithImageNamed:@"Coin00@2x"],
            [SKTexture textureWithImageNamed:@"Coin01@2x"],
            [SKTexture textureWithImageNamed:@"Coin02@2x"],
            [SKTexture textureWithImageNamed:@"Coin03@2x"],
            [SKTexture textureWithImageNamed:@"Coin04@2x"],
            [SKTexture textureWithImageNamed:@"Coin05@2x"]]
                        timePerFrame:0.10]]];
        [self addChild:self.coins];
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.coins forKey:@"coins"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.coins = [aDecoder decodeObjectForKey:@"coins"];
    }
    return self;
}
@end
