//
//  MenuScene.m
//  Hit Beans
//
//  Created by t2cn on 10-10-8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MenuScene.h"
using namespace std;//这个也要写上才行
#import "vector"//记得头文件啊
#include <iostream>

@implementation MenuScene
@synthesize isContinue;
+(id) scene {
	//CCScene *scene = [CCScene node];	
	MenuScene *layer = [MenuScene node];
	//[scene addChild: layer];
	return layer;
}

-(id) init {
	if ((self = [super init])) {
		[CCMenuItemFont setFontSize:32];
		[CCMenuItemFont setFontName: @"Arial"];
		
		CCColorLayer* layer = [CCColorLayer layerWithColor: ccc4(0xFF, 0xFF, 0xFF, 0xFF)];
		[self addChild: layer z:1];
		
		start = [CCMenuItemFont itemFromString: NSLocalizedString(@"START", @"start menu") target:self selector:@selector(onStart:)];
		[start setColor:ccc3(0x00, 0xCC, 0x00)];
		//cont = [CCMenuItemFont itemFromString: NSLocalizedString(@"CONTINUE", @"continue menu") target:self selector:@selector(onContinue:)];
		//[cont setColor:ccc3(0xFF, 0x99, 0x00)];
		//option = [CCMenuItemFont itemFromString: NSLocalizedString(@"SCORES", @"score menu") target:self selector:@selector(onOption:)];
		//[option setColor:ccc3(0x00, 0x66, 0xFF)];
		help = [CCMenuItemFont itemFromString: NSLocalizedString(@"HELP" ,@"help menu") target:self selector:@selector(onHelp:)];
		[help setColor:ccc3(0xFF, 0x66, 0x66)];
		CCMenu *menu = [CCMenu menuWithItems: start, /*cont, option, */help, nil];
		[menu alignItemsVerticallyWithPadding:20.0];
		
		// elastic effect
		CGSize s = [[CCDirector sharedDirector] winSize];
		int i=0;
		for( CCNode *child in [menu children] ) {
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
		[self addChild: menu z:2];
		
		//c ++ test
		int n = 9;
		vector<int>* vectors = new vector<int>[n];
		for(i=0; i<n; i++)
		{
			for(int j=0; j<i; j++)
			{
				int data;
				cin>>data;
				vectors[i].push_back(j);
			}
		}
		
		cout<<"共有"<<n<<"个vector，各vector元素如下："<<endl;
		for(i=0; i<n; i++)
		{
			cout<<"第"<<i+1<<"个vector的元素：";
			int j;
			for(j=0; j<vectors[i].size(); j++)
			{
				cout<<vectors[i][j]<<"\t";
			}
			cout<<endl;
		}
		delete [] vectors;
	}
	return self;
}

-(void) onStart:(id) sender {
	GameScene *scene = [GameScene scene];
	[[CCDirector sharedDirector] pushScene: [CCSlideInTTransition transitionWithDuration:1 scene:scene]];
}
-(void) onContinue:(id) sender {

}
-(void) onOption:(id) sender {

}
-(void) onHelp:(id) sender {
	HelpScene *scene = [HelpScene scene];
	[[CCDirector sharedDirector] pushScene: [CCSlideInTTransition transitionWithDuration:1 scene:scene]];
}
-(void) dealloc {
	[super dealloc];
}
@end
