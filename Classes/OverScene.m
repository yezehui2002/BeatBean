//
//  OverScene.m
//  Beat Bean
//
//  Created by t2cn on 10-10-13.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OverScene.h"
#import "GameScene.h"

@implementation OverScene
@synthesize menu, game, top, score;
+(id) scene {
	//CCScene *scene = [CCScene node];
	OverScene *over = [OverScene node];
	//[scene addChild:over z:1 tag:1];
	return over;
}
-(id) init {
	if ((self = [super init])) {
		[CCMenuItemFont setFontSize:32];
		[CCMenuItemFont setFontName: @"Arial"];
		
		self.top = [CCLabel labelWithString:[NSString stringWithFormat:@"0"] fontName:@"Arial" fontSize:32];
		[self addChild:self.top z: 3];
		//self.top.visible = NO;
		[self.top setColor:ccc3(255, 0, 0)];
		self.top.position = ccp(160, 370 -50);
		
		self.score = [CCLabel labelWithString:[NSString stringWithFormat:@"0"] fontName:@"Arial" fontSize:32];
		[self addChild:self.score z: 3];
		//self.top.visible = NO;
		[self.score setColor:ccc3(0, 0, 255)];
		self.score.position = ccp(160, 320 - 40);
		
		CCColorLayer* layer = [CCColorLayer layerWithColor: ccc4(0xFF, 0xFF, 0xFF, 0xFF)];
		[self addChild: layer z:1];
		
		CCMenuItemFont *reStart = [CCMenuItemFont itemFromString: NSLocalizedString(@"RESTART", @"restart the game") target:self selector:@selector(onReStart:)];
		[reStart setColor:ccc3(0x00, 0xCC, 0x00)];
		
		//CCMenuItemFont *upload = [CCMenuItemFont itemFromString: NSLocalizedString(@"UPLOAD", @"upload the score") target:self selector:@selector(onReStart:)];
		//[upload setColor:ccc3(0xBD, 0x69, 0x21)];
		
		self.menu = [CCMenu menuWithItems: reStart, /*upload,*/ nil];
		[self.menu alignItemsVerticallyWithPadding:20.0];
		[self addChild: self.menu z:2];
		[self initTop];
		
		//[self initPosition];
		//menu.visible = NO;
	}
	return self;
}
-(void) initTop {
	[self.top setString:[NSString stringWithFormat:NSLocalizedString(@"Best:%i", @"the user's best score"), self.game.top]];
	[self.score setString:[NSString stringWithFormat:NSLocalizedString(@"Score:%i", @"the user's current score"), self.game.score]];
}
-(void) initPosition {
	// elastic effect
	CGSize s = [[CCDirector sharedDirector] winSize];
	int i=0;
	for( CCNode *child in [self.menu children] ) {
		CGPoint dstPoint = child.position;
		int offset = s.width/2 + 50;
		if( i % 2 == 0)
			offset = -offset;
		child.position = ccp( dstPoint.x + offset, dstPoint.y);
		[child runAction: 
		 [CCEaseElasticOut actionWithAction:
		  [CCMoveBy actionWithDuration:2 position:ccp(dstPoint.x - offset,0)]
									 period: 0.35f]
		 ];
		i++;
	}
}
-(void) onReStart:(id) sender {
	[game initBubble];
	[[CCDirector sharedDirector] pushScene: [CCSlideInTTransition transitionWithDuration:1 scene:self.game]];
}
@end
