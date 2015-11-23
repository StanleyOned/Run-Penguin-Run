//
//  SBSlug.m
//  Run Penguin Run!
//
//  Created by Stanley Delacruz on 8/4/14.
//  Copyright (c) 2014 Stanley Delacruz. All rights reserved.
//

#import "SBSlug.h"
#import "SKEmitterNode+SKTExtras.h"

@implementation SBSlug
-(instancetype)init
{
    if (self = [super init]) {
        [self setup];
        
       // [self setupAnimation];
        
        
        
    }
    return self;
}
- (void)setup
{
    self.slug = [SKSpriteNode spriteNodeWithImageNamed:@"slug_1@2x"];
    self.slug.zPosition = 50;
    self.slug.physicsBody =
    [SKPhysicsBody bodyWithCircleOfRadius:4];
    self.slug.physicsBody.collisionBitMask = PCCategoryBackground;
    self.slug.physicsBody.contactTestBitMask = PCCategoryPlayer;
    self.slug.physicsBody.categoryBitMask = PCCategoryGhost;
    self.slug.physicsBody.allowsRotation = NO;
    self.slug.xScale = self.slug.yScale = 1.4f;
    self.slug.physicsBody.affectedByGravity = NO;
    self.slug.physicsBody.dynamic = NO;

   // [self animation];
    //[self setupAnimations];
    //[self startWalkingAnimation];
    [self.slug runAction:[SKAction repeatActionForever:[SKAction animateWithTextures:@[[SKTexture textureWithImageNamed:@"slug_1@2x.png"],
         [SKTexture textureWithImageNamed:@"slug_2@2x.png"],
          [SKTexture textureWithImageNamed:@"slug_3@2x.png"]
                        ]timePerFrame:0.09]]];
    [self addChild:self.slug];
    
   
}
-(void) encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:self.slug forKey:@"Slug"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.slug = [aDecoder decodeObjectForKey:@"Slug"];
    }
    return self;
}





@end
