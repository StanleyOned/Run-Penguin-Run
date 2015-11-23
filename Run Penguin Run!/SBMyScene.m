//
//  SBMyScene.m
//  Run Penguin Run!
//  
//  Created by Stanley Delacruz on 7/29/14.
//  Copyright (c) 2014 Stanley Delacruz. All rights reserved.
//

#import "SBMyScene.h"
#import "SBBackground.h"
#import "SBPlayer.h"
#import "SKTUtils.h"
#import "SKEmitterNode+SKTExtras.h"
//#import "SKAction+SKTExtras.h"
#import "SBSlug.h"
#import "SBGhost.h"
#import "SBCoins.h"

@implementation SBMyScene
{
    SBBackground *_background;
    //CFTimeInterval _lastUpdateInterval;
    SBPlayer *_player;
    SKLabelNode *_scoreLabel;
    double _score;
    int _backgroundMoveSpeed;
    SBSlug *_slug;
    int _life;
    SKLabelNode *_lifeNode;
    int _maximumEnemies;
    int _slugEnemies;
    SBGhost *_ghost;
    int _coins;
    PCGameState _gameState;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
       // _lastUpdateInterval = [aDecoder decodeObjectForKey:@"TimeInterval"];
        _background = [aDecoder decodeObjectForKey:@"Background"];
        _player = [aDecoder decodeObjectForKey:@"_player"];
        _scoreLabel = [aDecoder decodeObjectForKey:@"ScoreLabel"];
        _lifeNode = [aDecoder decodeObjectForKey:@"LifeNode"];
        _score = [aDecoder decodeDoubleForKey:@"_score"];
        _slugEnemies = [aDecoder decodeIntForKey:@"SlugEnemies"];
        _slug = [aDecoder decodeObjectForKey:@"Slugy"];
        _backgroundMoveSpeed = [aDecoder decodeIntForKey:@"BackgroundMoveSpeed"];
        _life = [aDecoder decodeIntForKey:@"Life"];
        _slugEnemies = [aDecoder decodeIntForKey:@"SlugEnemies"];
        
      switch (_gameState) {
            case PCGameStateInReloadMenu:
            case PCGameStatePlaying:
            {
                _gameState = PCGameStateInReloadMenu;
                    [self showReloadMenu];
                break;
            }
            default:
                break;
        }
      
    }
    return  self;
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    //[aCoder encode]
    [aCoder encodeObject:_player  forKey:@"_player"];
    [aCoder encodeObject:_background forKey:@"Background"];
    [aCoder encodeObject:_scoreLabel forKey:@"ScoreLabel"];
    [aCoder encodeObject:_lifeNode forKey:@"LifeNode"];
    [aCoder encodeDouble:_score forKey:@"_score"];
    [aCoder encodeObject:_slug forKey:@"Slugy"];
    [aCoder encodeInt:_backgroundMoveSpeed forKey:@"BackgroundMoveSpeed"];
    [aCoder encodeInt:_life forKey:@"Life"];
    [aCoder encodeInt:_maximumEnemies forKey:@"MaximumEnemies"];
    [aCoder encodeInt:_slugEnemies forKey:@"SlugEnemies"];
   
}
-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        _coins = 1;
        _maximumEnemies = 4;
        _slugEnemies = 2;
        _background = [SBBackground generateBackground];
        [self addChild:_background];
        _player = [[SBPlayer alloc]init];
        _player.position = CGPointMake(100, 60);
        [self addChild:_player];
        
        _backgroundMoveSpeed = 350;
        _score = 0;
        _scoreLabel = [[SKLabelNode alloc]initWithFontNamed:@"Chalkduster"];
        _scoreLabel.fontSize = 25;
       
        _scoreLabel.position = CGPointMake(155, 290);
        _scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        _scoreLabel.zPosition = 100;
        
        [self addChild:_scoreLabel];
        
        SKAction *tempAction = [SKAction runBlock:^{
            _scoreLabel.text = [NSString stringWithFormat:@"Score: %3.0f",_score];
            
        }];
        SKAction *action = [SKAction waitForDuration:0.2]; //every 0,2 it will change.
        
        [_scoreLabel runAction:[SKAction repeatActionForever:[SKAction sequence:@[tempAction,action]]]];
        self.physicsWorld.gravity = CGVectorMake(0, globalGravity);
        
       // _rotate = [SKAction rotateToAngle:25 duration:3];
        self.userInteractionEnabled = YES;
        self.physicsWorld.contactDelegate = self;
       
        _life = 3;
        _lifeNode = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        _lifeNode.text = [NSString stringWithFormat:@"Life: %d ",_life];
        _lifeNode.position = CGPointMake(445, 290);
        _lifeNode.fontSize = 25;
        _lifeNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        _lifeNode.zPosition = 100;
        [self addChild:_lifeNode];
        self.userInteractionEnabled = YES;
        //[self spawnEnemySlug];
        [self createUserInterface];
        
        for (int i = 0; i < _maximumEnemies ; i++) {
            [self addChild:[self spawnGhost]];
        }
        for (int i = 0; i < _slugEnemies; i++) {
            [self addChild:[self spawnEnemySlug]];
        }
        for (int i = 0; i < _coins; i++) {
            [self addChild:[self spawnCoins]];
        }
    }
    return self;
}
- (void)createUserInterface
{
    SKLabelNode *msg =
    [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    msg.name = @"startingM";
    msg.text = @"Tap screen to play!";
    msg.fontSize = 32;
    msg.position = CGPointMake(self.size.width /2, self.size.height/2 + 40);
    msg.zPosition = 100;
    [self addChild:msg];
}
- (SBGhost *)spawnGhost
{
    SBGhost *ghost = [[SBGhost alloc]init];
    ghost.position = CGPointMake(self.size.width + arc4random() % 800, arc4random() % 240 + 75);
    ghost.name = @"ghost";
    //[self addChild:ghost];
    return ghost;
}
- (SBSlug *)spawnEnemySlug
{
    SBSlug *slug = [[SBSlug alloc]init];
    slug.position = CGPointMake(self.size.width +  240, 63);
    slug.name = @"slug";
    return slug;
    
}
- (SBCoins *)spawnCoins
{
    SBCoins *coins = [[SBCoins alloc]init];
    coins.position = CGPointMake(self.size.width + arc4random() % 600, arc4random() % 200 + 30);
    coins.name = @"coinss";
    return coins;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
   
 
    switch (_gameState) {
        case PCGameStateStartingLevel:
        {
            [self childNodeWithName:@"startingM"].hidden = YES;
            _gameState = PCGameStatePlaying;
            self.paused = NO;
            //intentional break
        }
            case PCGameStatePlaying:
        {
            SBPlayer *player = (SBPlayer *)[self childNodeWithName:@"player"];
            player.jump = YES;
            UITouch *touch = [touches anyObject];
            [self showTapAtLocation:[touch locationInNode:self]];
             break;
        }
       case  PCGameStateMenu:
        {
            UITouch *touch = [touches anyObject];
            CGPoint loc = [touch locationInNode:self];
            SKNode *node = [self childNodeWithName:@"Try again?"];
            if ([node  containsPoint:loc]) {
                SBMyScene *scene = [[SBMyScene alloc]initWithSize:self.size];
                [self.view presentScene:scene transition:[SKTransition pushWithDirection:SKTransitionDirectionDown duration:0.5]];
            }
            break;
        }
            
        default:
            break;
    }
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    SBPlayer *player = (SBPlayer *)[self childNodeWithName:@"player"];
    player.jump = NO;
}
- (void)showReloadMenu
{
    SKLabelNode *label = (SKLabelNode*)[self childNodeWithName:@"startingM"];
    label.text = @"Found a Save File";
    label.hidden = NO;
    
    SKLabelNode *continueLabel = (SKLabelNode *)[self childNodeWithName:@"continueLabel"];
    if (!continueLabel) {
        continueLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        continueLabel.text = @"Resume?";
        continueLabel.name = @"continueLabel";
        continueLabel.fontSize = 28;
        continueLabel.zPosition = 100;
        continueLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        continueLabel.position = CGPointMake(0-20, -40);
        [self addChild:continueLabel];
        
        SKLabelNode *restartLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        restartLabel.text = @"Restart";
        restartLabel.name = @"restartLabel";
        restartLabel.fontSize = 28;
        restartLabel.zPosition = 100;
        restartLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        restartLabel.position = CGPointMake(0+20, - 40);
        [self addChild:restartLabel];
    }
}
- (void)showTapAtLocation:(CGPoint)point
{
    // 1
    UIBezierPath *path =
    [UIBezierPath bezierPathWithOvalInRect:
     CGRectMake(-3.0f, -3.0f, 6.0f, 6.0f)];
    
    // 2
    SKShapeNode *shapeNode = [SKShapeNode node];
    shapeNode.path = path.CGPath;
    shapeNode.position = point;
    shapeNode.strokeColor = SKColorWithRGBA(255, 255, 255, 196);
    shapeNode.lineWidth = 1;
    shapeNode.antialiased = NO;
    shapeNode.zPosition = 100;
    [self addChild:shapeNode];
    
    // 3
    const NSTimeInterval Duration = 0.6;
    
    SKAction *scaleAction = [SKAction scaleTo:6.0f
                                     duration:Duration];
    scaleAction.timingMode = SKActionTimingEaseOut;
    
    [shapeNode runAction:
     [SKAction sequence:@[scaleAction,
                          [SKAction removeFromParent]]]];
    
    // 4
    SKAction *fadeAction =
    [SKAction fadeOutWithDuration:Duration];
    fadeAction.timingMode = SKActionTimingEaseOut;
    [shapeNode runAction:fadeAction];
}
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    
    uint32_t collision = (contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask);
    if (collision == (PCCategoryPlayer | PCCategoryGhost)) {
 
        SKAction *blink = [SKAction fadeOutWithDuration:0.1];
        SKAction *blinkTwo = [SKAction fadeInWithDuration:0.1];
        SKAction *repeat = [SKAction sequence:@[blink,blinkTwo,blink,blinkTwo,blink,blinkTwo]];
       // _player.physicsBody.restitution = 0.8;
        [_player runAction:repeat];
        _life--;
        _lifeNode.text = [NSString stringWithFormat:@"Life: %i",_life];
        if (_life <= 0) {
            
            _player.physicsBody.categoryBitMask = PCCategoryDead;
            _player.paused = YES;
            _slug.paused = YES;
            [self GameOverWithBool:YES];
            if (_life <= 0) {
                _life = 0;
            }
        }
    }
}
- (void)GameOverWithBool:(BOOL)lose
{
    SKLabelNode *label = (SKLabelNode*)[self childNodeWithName:@"startingM"];
    label.hidden = NO;
    label.text = @"Game Over";
    label.fontSize = 50;
    label.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    
    SKLabelNode  *try = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    try.text = @"Try Again?";
    try.name = @"Try again?";
    try.position = CGPointMake(self.size.width/2, self.size.height/2 - 40);
    try.fontSize = 28;
    try.zPosition = 100;
    try.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    [self addChild:try];
    _player.physicsBody.linearDamping = 1;
    
    
    _gameState = PCGameStateMenu;
    _player.paused = YES;
    
}
- (void)didEndContact:(SKPhysicsContact *)contact
{
    
}


/*
- (void)tappedScreen:(UITapGestureRecognizer*)recognizer
{
    SBPlayer *player = (SBPlayer *)[self childNodeWithName:@"player"];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        player.jump = YES;
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        player.jump = NO;
    }
}
 */
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if ((_gameState == PCGameStateStartingLevel || _gameState == PCGameStateInReloadMenu) && !self.isPaused) {
        self.paused = YES;
    }
    if (_gameState != PCGameStatePlaying) {
        return;
    }
    if (_life == 0) {
        self.paused = YES;
        _slug.paused = YES;
        [_slug removeAllActions];
        
        _player.physicsBody = nil;
        
        [self GameOverWithBool:YES];
        return;
    }
    CFTimeInterval _lastUpdateInterval;
    CFTimeInterval timeSinceLast = currentTime - _lastUpdateInterval;
    _lastUpdateInterval = currentTime;
    
    if (timeSinceLast > 1) {
        timeSinceLast = 1.0 / 60.0;
        _lastUpdateInterval = currentTime;
    
        
    }
    [self enumerateChildNodesWithName:@"player" usingBlock:^(SKNode *node,BOOL *stop){
        SBPlayer *player = (SBPlayer *)node;
        if (player.jump) {
            [player.physicsBody applyForce:CGVectorMake(0, playerJumpForce * timeSinceLast)];
            
           
            player.animationState = playerStateJumping;
        } else if (_player.position.y <= 89 ) {
            player.animationState = playerStateRunning;
        }
        
    }];
    [self enumerateChildNodesWithName:@"bg" usingBlock:^(SKNode *node, BOOL *stop){
        node.position = CGPointMake(node.position.x - _backgroundMoveSpeed * timeSinceLast,node.position.y);
       
        if (node.position.x < - (node.frame.size.width + 100)) {
            [node removeFromParent]; //if it went completely off screen remove it
            _backgroundMoveSpeed += 5;
            
            if (_backgroundMoveSpeed >= 700) {
                _backgroundMoveSpeed = 500;
            }
        }
    }];
    if (_background.position.x < - 380) {
        SBBackground *anotherBackground = [SBBackground generateBackground];
        anotherBackground.position = CGPointMake(_background.position.x + _background.frame.size.width, 0);
        [ self addChild:anotherBackground];
        _background = anotherBackground;
    }
    _score = _score + (_backgroundMoveSpeed * timeSinceLast / 100); //update score
    
    [self enumerateChildNodesWithName:@"ghost" usingBlock:^(SKNode *node, BOOL *stop){
        SBGhost *enemy = (SBGhost *)node;
         enemy.position = CGPointMake(enemy.position.x - _backgroundMoveSpeed * timeSinceLast, enemy.position.y);
        if (enemy.position.x < -200) {
            enemy.position = CGPointMake(self.size.width + arc4random() % 800, arc4random() % 240 + 40);
        }
    }];
    
   [self enumerateChildNodesWithName:@"slug" usingBlock:^(SKNode *node,BOOL *stop){
    SBSlug *slug = (SBSlug *)node;
     
    slug.position = CGPointMake(slug.position.x - 100 * timeSinceLast, slug.position.y);
    if (slug.position.x < - 100) {
            slug.position = CGPointMake(self.size.width +  240, 63);
        }
   }];
    [self enumerateChildNodesWithName:@"coinss" usingBlock:^(SKNode *node, BOOL *stop){
        SBCoins *coins = (SBCoins *)node;
        coins.position = CGPointMake(coins.position.x -_backgroundMoveSpeed * timeSinceLast, coins.position.y);
        if (coins.position.x < - 500) {
            coins.position = CGPointMake(self.size.width + arc4random() % 600, arc4random() % 200 + 30);
        }
    }];
    
}

@end
