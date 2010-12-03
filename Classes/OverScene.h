//
//  OverScene.h
//  Beat Bean
//
//  Created by t2cn on 10-10-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
//#import "GameScene.h"
@class GameScene;
@interface OverScene : CCLayer {
	CCMenu *menu;
	GameScene *game;
	CCLabel *top;
	CCLabel *score;
}

+(id) scene;
@property (nonatomic, retain) CCMenu *menu;
@property (nonatomic, assign) GameScene *game;
@property (nonatomic, assign) CCLabel *top;
@property (nonatomic, assign) CCLabel *score;
-(void) initTop;
@end
