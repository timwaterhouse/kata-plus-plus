//
//  Kata.h
//  Kata Counter
//
//  Created by Tim Waterhouse on 22/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Kata : NSObject <NSCoding, NSCopying> {
	NSString *name;
	NSUInteger total;
}
@property (nonatomic, retain) NSString *name;
@property (nonatomic) NSUInteger total;
@end
