//
//  HelpScene.m
//  Beat Bean
//
//  Created by t2cn on 10-11-19.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HelpScene.h"


@implementation HelpScene

+(id) scene {
	HelpScene *help = [HelpScene node];
	return help;
}
-(id) init {
	if ((self = [super init])) {
		
	}
	return self;
}
-(void) dealloc
{
	[super dealloc];
}

-(void) onEnter
{
	[super onEnter];
	
	self.isTouchEnabled = YES;
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	// create the streak object and add it to the scene
	streak = [CCMotionStreak streakWithFade:3 minSeg:3 image:@"streak.png" width:32 length:32 color:ccc4(255,255,255,255)];
	[self addChild:streak];
	
	streak.position = ccp(s.width/2, s.height/2);
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint touchLocation = [touch locationInView: [touch view]];	
	touchLocation = [[CCDirector sharedDirector] convertToGL: touchLocation];
	
	[streak setPosition:touchLocation];
}
@end
