//
//  Kata.m
//  Kata Counter
//
//  Created by Tim Waterhouse on 22/04/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Kata.h"

#define kNameKey	@"Name"
#define kTotalKey	@"Total"

@implementation Kata
@synthesize name, total;

#pragma mark -
#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder {
	[encoder encodeObject:name forKey:kNameKey];
	[encoder encodeInteger:total forKey:kTotalKey];
//	[encoder encodeObject:[NSNumber numberWithUnsignedInt:total] forKey:kTotalKey];
}

- (id)initWithCoder:(NSCoder *)decoder {
	if (self = [super init]) {
		name = [[decoder decodeObjectForKey:kNameKey] retain];
		total = [decoder decodeIntegerForKey:kTotalKey];
	}
	return self;
}

#pragma mark -
#pragma mark NSCopying
- (id)copyWithZone:(NSZone *)zone {
	Kata *copy = [[[self class] allocWithZone:zone] init];
	copy.name = [[self.name copyWithZone:zone] autorelease];
	copy.total = self.total;
	return copy;
}

@end
