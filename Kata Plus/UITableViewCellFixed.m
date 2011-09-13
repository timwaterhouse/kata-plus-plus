//
//  UITableViewCellFixed.m
//  Kata++
//
//  Created by Timothy Waterhouse on 9/5/11.
//  Copyright 2011 NA. All rights reserved.
//

#import "UITableViewCellFixed.h"


@implementation UITableViewCellFixed

- (void) layoutSubviews {
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, 
                                      self.textLabel.frame.origin.y, 
                                      220.0, 
                                      self.textLabel.frame.size.height);
    self.detailTextLabel.frame = CGRectMake(230.0, 
                                            self.detailTextLabel.frame.origin.y, 
                                            60.0, 
                                            self.detailTextLabel.frame.size.height);
}

- (void)dealloc
{
    [super dealloc];
}

@end
