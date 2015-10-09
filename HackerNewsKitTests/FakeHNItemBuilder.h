//
//  FakeHNItemBuilder.h
//  HackerNewsKit
//
//  Created by Skye on 10/9/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HNItemBuilder.h"
@class HNItem;

@interface FakeHNItemBuilder : HNItemBuilder
@property (copy) NSString *JSON;
@property (copy) NSArray *arrayToReturn;
@property (copy) NSError *errorToSet;
@end
