//
//  SBGameKitHelper.h
//  CircuitRacers
//
//  Created by Stanley Delacruz on 8/15/14.
//  Copyright (c) 2014 Stanley Delacruz. All rights reserved.
//

#import <Foundation/Foundation.h>
@import GameKit;
extern NSString *const PresentAuthenticationViewController;
@interface SBGameKitHelper : NSObject
@property (nonatomic,readonly) UIViewController *authenticationViewController;
@property (nonatomic,readonly) NSError *lastError;

+(instancetype)sharedGameKitHelper;
- (void)authenticateLocalPlayer;
@end
//extern you are declaring this variable here but is expected to be defined elsewhere.