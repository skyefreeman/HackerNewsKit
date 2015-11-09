//
//  FakeHNItemBuilder.h
//  HackerNewsKit
//
//  Created by Skye on 10/9/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HNItemBuilder.h"

@interface FakeHNItemBuilder : HNItemBuilder
@property (copy) NSError *errorToSet;

@property (copy) NSString *JSON;
@property (copy) NSArray *JSONArray;

@property (copy) NSArray *arrayToReturn;
@property (strong) HNItem *itemToReturn;
@end
