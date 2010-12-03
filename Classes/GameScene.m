//
//  GameScene.m
//  Hit Beans
//
//  Created by t2cn on 10-10-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameScene.h"
#import "OverScene.h"
#import "Common.h"

@implementation GameScene
@synthesize bg, sheet, grids, bubbles, remain, upArray, downArray, leftArray, rightArray, 
			actionList, no, time, score, timeLine, timeMask, open, close, scoreLabel, maskLayer,
			restart, over, top;

+(id) scene {
	//CCScene *scene = [CCScene node];
	GameScene *game = [GameScene node];
	//[scene addChild:game];
	return game;
}
-(id) init {
	if ((self = [super init])) {
		self.bg = [CCSprite spriteWithFile:@"bg.png"];
		[self.bg setAnchorPoint:ccp(0,0)];
		[self.bg setPosition:ccp(-43,0)];
		[self addChild:bg z:-1];

		self.sheet = [CCSpriteSheet spriteSheetWithFile:@"bubble2.png" capacity:50];
		[self addChild:sheet z:0 tag:100];
		
		self.bubbles = [NSMutableArray arrayWithCapacity:70];
		self.actionList = [NSMutableArray arrayWithCapacity:4];
		self.remain = [NSMutableArray arrayWithCapacity:70];
		self.no = [CCSprite spriteWithTexture:sheet.texture rect:CGRectMake(0, 43, 43, 43)];
		[self.no retain];
		self.no.tag = NoType;
		for (int i = 0; i < 70; i ++) {
			[self.remain addObject:self.no];
		}
		
		self.upArray = [NSMutableArray arrayWithCapacity:4];
		self.downArray = [NSMutableArray arrayWithCapacity:4];
		self.leftArray = [NSMutableArray arrayWithCapacity:4];
		self.rightArray = [NSMutableArray arrayWithCapacity:4];	
		
		//timeline and timemask
		self.timeLine = [CCColorLayer layerWithColor: ccc4(244, 208, 208, 0xFF)];
		self.timeLine.position = ccp(5, 459);
		self.timeLine.anchorPoint = ccp(0, 0);
		[self.timeLine setContentSize:CGSizeMake(190, 12)];
		[self addChild:self.timeLine z:3 tag: 5];
		self.timeMask = [CCSprite spriteWithFile:@"timeMask.png"];
		self.timeMask.anchorPoint = ccp(0,0);
		self.timeMask.position = ccp(4, 458);
		[self addChild:self.timeMask z:4 tag: 6];
		
		//open button
		self.open = [CCSprite spriteWithFile:@"open.png"];
		self.open.anchorPoint = ccp(0, 0);
		self.open.position = ccp(280, 450);
		[self addChild:self.open z:5 tag:7];
		self.open.visible = [[NSUserDefaults standardUserDefaults] boolForKey:@"BBSoundBOOL"];
		
		//close button
		self.close = [CCSprite spriteWithFile:@"close.png"];
		self.close.anchorPoint = ccp(0, 0);
		self.close.position = ccp(280, 450);
		[self addChild:self.close z:5 tag:7];
		self.close.visible = ! self.open.visible;
		[Common sharedCommon].isPlay = self.open.visible;
		
		//score label
		self.scoreLabel = [CCLabel labelWithString:@"0" fontName:@"Courier" fontSize:24];
		self.scoreLabel.position = ccp(250,465);
		[self.scoreLabel setColor:ccc3(225, 79, 0)];
		[self addChild:self.scoreLabel z:6 tag:8];
		
		//maskLayer
		//self.maskLayer = [CCColorLayer layerWithColor:ccc4(181, 183, 180, 160)];
		//self.maskLayer.anchorPoint = ccp(0, 0);
		//self.maskLayer.position = ccp(0, 0);
		//[self addChild:self.maskLayer z:99 tag: 99];
		//self.maskLayer.visible = NO;
		
		//restart label
		self.restart = [CCLabel labelWithString:@"RESTART" fontName:@"Courier" fontSize:32];
		//blue * 10
		for (int i = 0; i < 10; i ++) {
			CCSprite *blue = [CCSprite spriteWithTexture:sheet.texture rect:CGRectMake(43*8, 0, 43, 43)];
			blue.tag = BlueType;
			[self.bubbles addObject:blue];
			[sheet addChild:blue z:0];
		}
		
		//green * 10
		for (int i = 0; i < 10; i ++) {
			CCSprite *green = [CCSprite spriteWithTexture:sheet.texture rect:CGRectMake(43*6, 0, 43, 43)];
			green.tag = GreenType;
			[self.bubbles addObject:green];
			[sheet addChild:green z:0];
			//NSLog(@"%i-%i-%i-%x", p, x, y, [green tag]);
		}
		
		//red * 10
		for (int i = 0; i < 10; i ++) {
			CCSprite *red = [CCSprite spriteWithTexture:sheet.texture rect:CGRectMake(43*1, 0, 43, 43)];
			red.tag = RedType;
			[self.bubbles addObject:red];
			[sheet addChild:red z:0];
			//NSLog(@"%i-%i-%i-%x", p, x, y, [red tag]);
		}
		
		//orange * 10
		for (int i = 0; i < 10; i ++) {
			CCSprite *orange = [CCSprite spriteWithTexture:sheet.texture rect:CGRectMake(43*4, 0, 43, 43)];
			orange.tag = OrangeType;
			[self.bubbles addObject:orange];
			[sheet addChild:orange z:0];
			//NSLog(@"%i-%i-%i-%x", p, x, y, [orange tag]);
		}
		
		//purple * 10
		for (int i = 0; i < 10; i ++) {
			CCSprite *purple = [CCSprite spriteWithTexture:sheet.texture rect:CGRectMake(43*2, 0, 43, 43)];
			purple.tag = PurpleType;
			[self.bubbles addObject:purple];
			[sheet addChild:purple z:0];
			//NSLog(@"%i-%i-%i-%x", p, x, y, [purple tag]);
		}
		
		[self initBubble];
		[self setIsTouchEnabled:YES];
		//[self scheduleUpdate];
		
		self.over = [OverScene scene];
		self.over.game = self;
		
		self.top = [[NSUserDefaults standardUserDefaults] integerForKey:@"BBTopScoreInteger"];
	}
	return self;
}
-(void) initGrid:(int) capacity {
	self.grids = [NSMutableArray arrayWithCapacity:capacity];
	for (int i = 0; i < capacity; i ++) {
		NSNumber *n = [[NSNumber alloc] initWithInt:i];
		[self.grids addObject:n];
		[n release];
	}
}
-(void) draw {
	//glEnable(GL_LINE_SMOOTH); // This line could be moved out of this method
	//glColor4ub(255,0,0,255); // Could this line be moved out of this method?
	//ccDrawLine( ccp(160, 240), ccp(160, 155) );
	[super draw]; // Depending on the superclass
}
-(void) tick:(ccTime)dt
{
	time --;
	[self.timeLine setContentSize:CGSizeMake(time*10.0f, 12.0f)];
	if (time == 0) {
		[self unschedule:@selector(tick:)];
		//self.maskLayer.visible = YES;
		if (self.score > self.top) {
			self.top = self.score;
			[[NSUserDefaults standardUserDefaults] setInteger:self.score forKey:@"BBTopScoreInteger"];
			//NSLog(@"%i", self.top);
		}
		[self.over initTop];
		[[Common sharedCommon] playOverSound];
		[[CCDirector sharedDirector] pushScene: [CCSlideInTTransition transitionWithDuration:1 scene:self.over]];
	}
}

-(void) update: (ccTime) time {

}

-(int) getGrid {
	int r = arc4random()%([self.grids count]);
	NSNumber *n = [self.grids objectAtIndex:r];
	[self.grids removeObjectAtIndex:r];
	return n.intValue;
}

-(void) initBubble {
	[self.remain removeAllObjects];
	for (int i = 0; i < 70; i ++) {
		[self.remain addObject:self.no];
	}
	[self initGrid: 70];
	for (CCSprite *b in self.bubbles) {
		int p = [self getGrid];
		int x = p%7;
		int y = p/7;
		b.position = ccp(x*45 + 22.5 + 2, y*45 + 22.5);
		b.tag |= p;
		[self.sheet reorderChild:b z:0];
		[self.remain replaceObjectAtIndex:p withObject:b];
		//NSLog(@"%i-%i-%i-%x", p, x, y, b.tag);
	}
	time = 20;
	score = 0;
	[self.scoreLabel setString:@"0"];
	//time timer
	[self schedule:@selector(tick:) interval:1.0f];
	//NSLog(@"%i", self.top);
}

-(void) registerWithTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:INT_MIN+1 swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint point = [touch locationInView:nil];
	CGPoint gp = [[CCDirector sharedDirector] convertToGL:point];
	int x = (int)((gp.x - 2)/45);
	int y = (int)(gp.y/45);
	//NSLog(@"%f-%f", gp.x, gp.y);
	//NSLog(@"%i-%i", x, y);
	int p = y*7 + x;
	if (p > 75) {
		if (self.open.visible) {
			self.open.visible = NO;
			self.close.visible = YES;
		}else {
			self.open.visible = YES;
			self.close.visible = NO;
		}
		[Common sharedCommon].isPlay = self.open.visible;
		[[NSUserDefaults standardUserDefaults] setBool:self.open.visible forKey:@"BBSoundBOOL"];
		return YES;
	}else if (p >= 70) {
		return YES;
	}
	CCSprite *s = [self.remain objectAtIndex:p];
	if ((s.tag == 0xFFF00000 ) || s == nil ) {
		if ([self shouldHit:x withY:y]) {
			[self playAnimationWithBeans];
			//hit
		}else {
			//time - 1;
			[self.upArray removeAllObjects];
			[self.downArray removeAllObjects];
			[self.leftArray removeAllObjects];
			[self.actionList removeAllObjects];
			time --;
			[self.timeLine setContentSize:CGSizeMake(time*10.0f, 12.0f)];
			if (time == 0) {
				[self unschedule:@selector(tick:)];
				//self.maskLayer.visible = YES;
				if (self.score > self.top) {
					self.top = self.score;
					[[NSUserDefaults standardUserDefaults] setInteger:self.score forKey:@"BBTopScoreInteger"];
					//NSLog(@"%i", self.top);
				}
				[self.over initTop];
				[[Common sharedCommon] playOverSound];
				[[CCDirector sharedDirector] pushScene: [CCSlideInTTransition transitionWithDuration:1 scene:self.over]];
			}else {
				[[Common sharedCommon] playWrongSound];
			}
		}
	}
	return YES;
}
-(BOOL) shouldHit:(int) x withY:(int) y {
	int upX, upY, downX, downY, leftX, leftY, rightX, rightY;
	
	int upType, downType, leftType, rightType;
	
	//up
	upX = x;
	upY = y;
	if (upY < 10 - 1) {
		upY ++;
		while ([[self.remain objectAtIndex:upY*7 + upX] tag] == 0xFFF00000) {
			upY ++;
			if (upY >= 10) {
				upY = -1;
				upX = -1;
				break;
			}
		}	
	}else {
		upX = -1;
		upY = -1;
	}
	if (upX != -1 || upY != -1) {
		upType = [[self.remain objectAtIndex:upY*7 + upX] tag] & 0xFFFF0000;
	}else {
		upType = -1;
	}

	//NSLog(@"%i-%i-%x", upX, upY, upType);
	
	//down
	downX = x;
	downY = y;
	if (downY > 0) {
		downY --;
		while ([[self.remain objectAtIndex:downY*7 + downX] tag] == 0xFFF00000) {
			downY --;
			if (downY <= -1) {
				downY = -1;
				downX = -1;
				break;
			}
		}	
	}else {
		downX = -1;
		downY = -1;
	}
	if (downX != -1 || downY != -1) {
		downType = [[self.remain objectAtIndex:downY*7 + downX] tag] & 0xFFFF0000;
	}else {
		downType = -1;
	}
	//NSLog(@"%i-%i-%x", downX, downY, downType);
	
	//left
	leftX = x;
	leftY = y;
	if (leftX > 0) {
		leftX --;
		while ([[self.remain objectAtIndex:leftY*7 + leftX] tag] == 0xFFF00000) {
			leftX --;
			if (leftX <= -1) {
				leftY = -1;
				leftX = -1;
				break;
			}
		}	
	}else {
		leftX = -1;
		leftY = -1;
	}
	if (leftX != -1 || leftY != -1) {
		leftType = [[self.remain objectAtIndex:leftY*7 + leftX] tag] & 0xFFFF0000;
	}else {
		leftType = -1;
	}
	//NSLog(@"%i-%i-%x", leftX, leftY, leftType);
	
	//right
	rightX = x;
	rightY = y;
	if (rightX < 7 - 1) {
		rightX ++;
		while ([[self.remain objectAtIndex:rightY*7 + rightX] tag] == 0xFFF00000) {
			rightX ++;
			if (rightX >= 7) {
				rightY = -1;
				rightX = -1;
				break;
			}
		}	
	}else {
		rightX = -1;
		rightY = -1;
	}
	if (rightX != -1 || rightY != -1) {
		rightType = [[self.remain objectAtIndex:rightY*7 + rightX] tag] & 0xFFFF0000;
	}else {
		rightType = -1;
	}
	//NSLog(@"%i-%i-%x", rightX, rightY, rightType);
	
	//group strategy
	int up, down, left;
	BOOL isAddDown, isAddLeft, isAddRight;
	isAddDown = isAddLeft = isAddRight = NO;
	if (upType != -1) {
		up = 1;
		[self.upArray addObject:[self.remain objectAtIndex:upY*7 + upX]];
		int x = 160+(arc4random()%400 - 200);
		int h = 200+(arc4random()%100 - 50);
		//id actionUp = [[CCJumpTo alloc] initWithDuration:1 position:ccp(x, -50) height:h jumps:1];
		id actionUp = [CCJumpTo actionWithDuration:1 position:ccp(x, -50) height:h jumps:1];
		//NSLog(@"%@#%i#%i", actionUp, x, h);
		[self.actionList addObject:actionUp];
		//NSLog(@"%i", [actionUp retainCount]);
		//[actionUp release];
		//NSLog(@"%i", [actionUp retainCount]);
		if (upType == downType) {
			up ++;
			isAddDown = YES;
			[self.upArray addObject:[self.remain objectAtIndex:downY*7 + downX]];
			int x = 160+(arc4random()%400 - 200);
			int h = 200+(arc4random()%100 - 50);
			id actionDown = [CCJumpTo actionWithDuration:1 position:ccp(x, -50) height:h jumps:1];
			//NSLog(@"%@#%i#%i", actionDown, x, h);
			[self.actionList addObject:actionDown];
		}
		if (upType == leftType) {
			up ++;
			isAddLeft = YES;
			[self.upArray addObject:[self.remain objectAtIndex:leftY*7 + leftX]];
			int x = 160+(arc4random()%400 - 200);
			int h = 200+(arc4random()%100 - 50);
			id actionLeft = [CCJumpTo actionWithDuration:1 position:ccp(x, -50) height:h jumps:1];
			//NSLog(@"%@#%i#%i", actionLeft, x, h);
			[self.actionList addObject:actionLeft];
		}
		if (upType == rightType) {
			up ++;
			isAddRight = YES;
			[self.upArray addObject:[self.remain objectAtIndex:rightY*7 + rightX]];
			int x = 160+(arc4random()%400 - 200);
			int h = 200+(arc4random()%100 - 50);
			id actionRight = [CCJumpTo actionWithDuration:1 position:ccp(x, -50) height:h jumps:1];
			//NSLog(@"%@#%i#%i", actionRight, x, h);
			[self.actionList addObject:actionRight];			
		}
	}else {
		up = 0;
	}

	if (downType != -1 && !isAddDown) {
		down = 1;
		[self.downArray addObject:[self.remain objectAtIndex:downY*7 + downX]];
		int x = 160+(arc4random()%400 - 200);
		int h = 200+(arc4random()%100 - 50);
		id actionDown = [CCJumpTo actionWithDuration:1 position:ccp(x, -50) height:h jumps:1];
		//NSLog(@"%@#%i#%i", actionDown, x, h);
		[self.actionList addObject:actionDown];
		if (downType == leftType && !isAddLeft) {
			down ++;
			isAddLeft = YES;
			[self.downArray addObject:[self.remain objectAtIndex:leftY*7 + leftX]];
			int x = 160+(arc4random()%400 - 200);
			int h = 200+(arc4random()%100 - 50);
			id actionLeft = [CCJumpTo actionWithDuration:1 position:ccp(x, -50) height:h jumps:1];
			//NSLog(@"%@#%i#%i", actionLeft, x, h);
			[self.actionList addObject:actionLeft];
		}
		if (downType == rightType && !isAddRight) {
			[self.downArray addObject:[self.remain objectAtIndex:rightY*7 + rightX]];
			int x = 160+(arc4random()%400 - 200);
			int h = 200+(arc4random()%100 - 50);
			id actionRight = [CCJumpTo actionWithDuration:1 position:ccp(x, -50) height:h jumps:1];
			//NSLog(@"%@#%i#%i", actionRight, x, h);
			[self.actionList addObject:actionRight];
			isAddRight = YES;
			down ++;
		}
	}else {
		down = 0;
	}

	if (leftType != -1 && !isAddLeft) {
		left = 1;
		[self.leftArray addObject:[self.remain objectAtIndex:leftY*7 + leftX]];
		int x = 160+(arc4random()%400 - 200);
		int h = 200+(arc4random()%100 - 50);
		id actionLeft = [CCJumpTo actionWithDuration:1 position:ccp(x, -50) height:h jumps:1];
		//NSLog(@"%@#%i#%i", actionLeft, x, h);
		[self.actionList addObject:actionLeft];
		if (leftType == rightType && !isAddRight) {
			left ++;
			isAddRight = YES;
			[self.leftArray addObject:[self.remain objectAtIndex:rightY*7 + rightX]];
			int x = 160+(arc4random()%400 - 200);
			int h = 200+(arc4random()%100 - 50);
			id actionRight = [CCJumpTo actionWithDuration:1 position:ccp(x, -50) height:h jumps:1];
			//NSLog(@"%@#%i#%i", actionRight, x, h);
			[self.actionList addObject:actionRight];
		}
	}else {
		left = 0;
	}
	if (up > 1 || down > 1 || left > 1) {
		return YES;
	}else {
		return NO;
	}
}
-(void)playAnimationWithBeans {
	int j = 0;
	//NSLog(@"-----------------------------");
	if ([self.upArray count] > 1) {
		for (CCSprite *s in self.upArray) {
			[self.sheet reorderChild:s z:2];
			[s runAction:[self.actionList objectAtIndex:j ++]];
			int index = [self.remain indexOfObject:s];
			//NSLog(@"%@#%i#%x#%i", s, index, s.tag, j);
			[self.remain replaceObjectAtIndex: index withObject:self.no];
		}
		self.score += [self.upArray count];
	}
	//NSLog(@"-----------------------------");	
	if ([self.downArray count] > 1) {
		for (CCSprite *s in self.downArray) {
			[self.sheet reorderChild:s z:2];
			[s runAction:[self.actionList objectAtIndex:j ++]];
			int index = [self.remain indexOfObject:s];
			//NSLog(@"%@#%i#%x#%i", s, index, s.tag, j);
			[self.remain replaceObjectAtIndex: index withObject:self.no];
		}
		self.score += [self.downArray count];
	}
	//NSLog(@"-----------------------------");	
	if ([self.leftArray count] > 1) {
		for (CCSprite *s in self.leftArray) {
			[self.sheet reorderChild:s z:2];
			[s runAction:[self.actionList objectAtIndex:j ++]];
			int index = [self.remain indexOfObject:s];
			//NSLog(@"%@#%i#%x#%i", s, index, s.tag, j);
			[self.remain replaceObjectAtIndex: index withObject:self.no];
		}
		self.score += [self.leftArray count];
	}
	[self.scoreLabel setString:[NSString stringWithFormat:@"%i", self.score]];
	[self.upArray removeAllObjects];
	[self.downArray removeAllObjects];
	[self.leftArray removeAllObjects];
	[self.actionList removeAllObjects];
	
	[[Common sharedCommon] playRightSound];
}
-(void) dealloc {
	[sheet release];
	[bg release];
	[self.grids release];
	[self.bubbles release];
	[self.remain release];
	[self.actionList release];
	[self.no release];
	[self.upArray release];
	[self.downArray release];
	[self.leftArray release];
	[self.rightArray release];
	[super dealloc];
}
@end
