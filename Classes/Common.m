//
//  Common.m
//  Hit Beans
//
//  Created by t2cn on 10-10-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Common.h"
#import "SimpleAudioEngine.h"

static Common *_c = nil;

@implementation Common

@synthesize isPlay;

+(Common *)sharedCommon {
	if (!_c) {
		_c = [[Common alloc] init];
	}
	return _c;
}

-(id) init {
	if ((self=[super init])) {
		overSound = [[NSBundle mainBundle] pathForResource:@"1" ofType:@"mp3"];
		rightKick = [[NSBundle mainBundle] pathForResource:@"3" ofType:@"mp3"];
		wrongKick = [[NSBundle mainBundle] pathForResource:@"22" ofType:@"mp3"];
		[[SimpleAudioEngine sharedEngine] preloadEffect:overSound];
		[[SimpleAudioEngine sharedEngine] preloadEffect:rightKick];
		[[SimpleAudioEngine sharedEngine] preloadEffect:wrongKick];
	}
	return self;
}
-(void) playOverSound {
	if (!isPlay) {
		return;
	}
	[[SimpleAudioEngine sharedEngine] playEffect:overSound];
}
-(void) playRightSound {
	if (!isPlay) {
		return;
	}
	[[SimpleAudioEngine sharedEngine] playEffect:rightKick];
}
-(void) playWrongSound {
	if (!isPlay) {
		return;
	}
	[[SimpleAudioEngine sharedEngine] playEffect:wrongKick];
}
-(void) dealloc {
	[SimpleAudioEngine end];
	[super dealloc];
}
@end
