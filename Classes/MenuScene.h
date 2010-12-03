//
//  MenuScene.h
//  Hit Beans
//
//  Created by t2cn on 10-10-8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameScene.h"
#import "HelpScene.h"

@interface MenuScene : CCLayer {
	CCMenuItemFont *start;
	CCMenuItemFont *cont;
	CCMenuItemFont *option;
	CCMenuItemFont *help;
	BOOL isContinue;
}

+(id) scene;
-(void) onStart:(id) sender;
-(void) onContinue:(id) sender;
-(void) onOption:(id) sender;
-(void) onHelp:(id) sender;
@property (nonatomic, assign) BOOL isContinue;

@end
