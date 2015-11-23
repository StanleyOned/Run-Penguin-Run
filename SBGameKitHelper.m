//
//  SBGameKitHelper.m
//  CircuitRacers
//
//  Created by Stanley Delacruz on 8/15/14.
//  Copyright (c) 2014 Stanley Delacruz. All rights reserved.
//

#import "SBGameKitHelper.h"
NSString *const PresentAuthenticationViewController =
@"present_authentication_view_controller";
@implementation SBGameKitHelper
{
    BOOL _enabledGameCenter;
}
+ (instancetype)sharedGameKitHelper
{
    //this method is creating and returning a singleton.
    static SBGameKitHelper *sharedGameKitHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameKitHelper = [[SBGameKitHelper alloc]init];
    });
    return sharedGameKitHelper;
}
- (id)init
{
    self = [super init];
    if (self) {
        _enabledGameCenter = YES;
    }
    return self;
}
- (void)authenticateLocalPlayer
{
    //1 the player who is currently authenticated in this device...
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    
    //2
    localPlayer.authenticateHandler =
    ^(UIViewController *viewController,NSError *error) {
        //3 store any error that the callback may received using this method.
        [self setLastError:error];
        if (viewController != nil) {
            //4 this is to check if the player has Game Center if it does it will be authenticated and game center will be authenticated if its not it will set it to NO.
            [self setAuthenticationViewController:viewController];
        } else if ([GKLocalPlayer localPlayer].isAuthenticated) {
            //5
            _enabledGameCenter = YES;
        } else {
            //6
            _enabledGameCenter = NO;
        }
    };
}
- (void)setAuthenticationViewController:(UIViewController *)authenticationViewController
{
    if (authenticationViewController != nil) {
        _authenticationViewController = authenticationViewController;
        [[NSNotificationCenter defaultCenter]postNotificationName:PresentAuthenticationViewController object:self];
        //this store the view controller and sends the notification.
    }
}
- (void)setLastError:(NSError *)error
{
    //this will sent all the errors back when the authentication process is being called.
    _lastError = [error copy];
    if (_lastError) {
        NSLog(@"GameKitHelper ERROR: %@",[[_lastError userInfo]description]);
    }
}
@end
