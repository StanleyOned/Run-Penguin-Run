//
//  Header.h
//  Run Penguin Run!
//
//  Created by Stanley Delacruz on 7/29/14.
//  Copyright (c) 2014 Stanley Delacruz. All rights reserved.
//

#ifndef Run_Penguin_Run__Header_h
#define Run_Penguin_Run__Header_h

static NSString *backgroundName = @"bg";
//static int backgroundMoveSpeed = 250;
static NSString *playerName = @"player";
static NSInteger playerMass = 80;
static NSInteger playerJumpForce = 7000000;
static NSInteger globalGravity = - 4.8;

typedef NS_OPTIONS(uint32_t, PCCategory)
{
    PCCategoryBackground = 1 << 0,
    PCCategoryPlayer =  1 << 1,
   // PCCategoryWater = 1 << 2,
    PCCategoryGhost = 1 << 2,
    PCCategorySlug = 1 << 3,
    PCCategoryDead = 1 << 4,
    PCCategoryCoin = 1 << 5,
};

typedef NS_ENUM(uint32_t,PCGameState)
{
    PCGameStateStartingLevel,
    PCGameStatePlaying,
    PCGameStateMenu,
    PCGameStateInReloadMenu,
};

#endif
