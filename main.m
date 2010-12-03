//
//  main.m
//  Hit Beans
//
//  Created by t2cn on 10-10-8.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
	NSAutoreleasePool *pool = [NSAutoreleasePool new];
	
#ifdef __GNUC__

#endif
	printf("---------------------\n");
#ifdef __arm
	__asm__ volatile(
			"mov r0, r0"
			);
#endif
	int retVal = UIApplicationMain(argc, argv, nil, @"Hit_BeansAppDelegate");
	[pool release];
	return retVal;
}
