//
//  HNItem.m
//  HackerNewsKit
//
//  Created by Skye on 10/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HNItem.h"

@implementation HNItem

- (instancetype)init {
    return nil;
}

- (instancetype)initWithID:(NSString*)ID {
    self = [super init];
    if (!self) return nil;
    
    self.ID = ID;
    
    return self;
}

@end
