//
//  HelpScene.h
//  Beat Bean
//
//  Created by t2cn on 10-11-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HelpScene : CCLayer {
	CCNode* root;
	CCNode* target;
	CCMotionStreak* streak;
}

+(id) scene;

@end
