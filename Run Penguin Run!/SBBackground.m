//
//  SBBackground.m
//  Run Penguin Run!
//
//  Created by Stanley Delacruz on 7/29/14.
//  Copyright (c) 2014 Stanley Delacruz. All rights reserved.
//

#import "SBBackground.h"

@implementation SBBackground
+ (SBBackground *)generateBackground
{
    SBBackground *background = [[SBBackground alloc]initWithImageNamed:@"Background"];
    background.anchorPoint = CGPointMake(0, 0);
    background.position = CGPointMake(0, 0);
    background.name = @"bg";
    background.zPosition = 1;
    background.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(-110, 43) toPoint:CGPointMake(background.size.width + 500, 43)];
    background.physicsBody.collisionBitMask = PCCategoryPlayer;
    background.physicsBody.categoryBitMask = PCCategoryBackground;
    background.physicsBody.affectedByGravity = NO;
    background.physicsBody.dynamic = NO;
    
    //topcollider
    SKNode *topCollider = [SKNode node];
    topCollider.position = CGPointMake(0, 0);
    topCollider.physicsBody = [SKPhysicsBody bodyWithEdgeFromPoint:CGPointMake(0, background.size.height - 15) toPoint:CGPointMake(background.size.width, background.size.height - 15)];
    topCollider.physicsBody.collisionBitMask = PCCategoryPlayer;
    topCollider.physicsBody.restitution = 0.1;
    topCollider.physicsBody.angularDamping = 0;
    [background addChild:topCollider];
    
    
    return background;
}

@end
