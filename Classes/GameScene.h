//
//  GameScene.h
//  Hit Beans
//
//  Created by t2cn on 10-10-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Common.h"
//#import "OverScene.h"

@class OverScene;
@interface GameScene : CCLayer {
	CCSprite *bg;
	CCSpriteSheet *sheet;
	NSMutableArray *grids;
	NSMutableArray *bubbles;
	NSMutableArray *remain;
	NSMutableArray *upArray;
	NSMutableArray *downArray;
	NSMutableArray *leftArray;
	NSMutableArray *rightArray;
	NSMutableArray *actionList;
	CCSprite *no;
	int time;
	int score;
	CCLabel *scoreLabel;
	CCLayer *timeLine;
	CCSprite *timeMask;
	CCSprite *open;
	CCSprite *close;
	CGPoint vertices[4];
	CCLayer *maskLayer;
	CCLabel *restart;
	OverScene *over;
	NSInteger top;
}
+(id) scene;
@property (nonatomic, assign) CCSprite *bg;
@property (nonatomic, assign) CCSpriteSheet *sheet;
@property (nonatomic, retain) NSMutableArray *grids;
@property (nonatomic, retain) NSMutableArray *bubbles;
@property (nonatomic, retain) NSMutableArray *remain;
@property (nonatomic, retain) NSMutableArray *upArray;
@property (nonatomic, retain) NSMutableArray *downArray;
@property (nonatomic, retain) NSMutableArray *leftArray;
@property (nonatomic, retain) NSMutableArray *rightArray;
@property (nonatomic, retain) NSMutableArray *actionList;
@property (nonatomic, assign) CCSprite *no;
@property (nonatomic, assign) CCSprite *open;
@property (nonatomic, assign) CCSprite *close;
@property (nonatomic, assign) int time;
@property (nonatomic, assign) int score;
@property (nonatomic, assign) CCLayer *timeLine;
@property (nonatomic, assign) CCSprite *timeMask;
@property (nonatomic, assign) CCLabel *scoreLabel;
@property (nonatomic, assign) CCLayer *maskLayer;
@property (nonatomic, assign) CCLabel *restart;
@property (nonatomic, retain) OverScene *over;
@property (nonatomic, assign) NSInteger top;
-(BOOL) shouldHit:(int) x withY:(int) y ;
-(void)playAnimationWithBeans ;
-(void) initBubble ;
@end
