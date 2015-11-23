//
//  SBCircuitRacerNavigationController.m
//  CircuitRacers
//
//  Created by Stanley Delacruz on 8/15/14.
//  Copyright (c) 2014 Stanley Delacruz. All rights reserved.
//

#import "SBCircuitRacerNavigationController.h"
#import "SBGameKitHelper.h"
@interface SBCircuitRacerNavigationController ()

@end

@implementation SBCircuitRacerNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showAuthenticationViewController) name:@"PresentAuthenticationViewController" object:nil];
    
    [[SBGameKitHelper sharedGameKitHelper]authenticateLocalPlayer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showAuthenticationViewController

{
    SBGameKitHelper *gameKitHelper =
    [SBGameKitHelper sharedGameKitHelper];
    
    [self.topViewController presentViewController:gameKitHelper.authenticationViewController animated:YES
                                         completion:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
