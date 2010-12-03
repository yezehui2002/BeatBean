//
//  Common.h
//  Hit Beans
//
//  Created by t2cn on 10-10-9.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _BubbleType {
	NoType = 0xFFF00000,
	BlueType = 0xFFF10000,
	GreenType = 0xFFF20000,
	RedType = 0xFFF30000,
	OrangeType = 0xFFF40000,
	PurpleType = 0xFFF50000
}BubbleType;


@interface Common : NSObject {
	NSString *overSound;
	NSString *rightKick;
	NSString *wrongKick;
	BOOL isPlay;
}
+(Common *)sharedCommon ;
-(void) playOverSound ;
-(void) playRightSound ;
-(void) playWrongSound ;
@property (nonatomic, assign) BOOL isPlay;

@end
