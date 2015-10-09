//
//  FakeHNItemBuilder.m
//  HackerNewsKit
//
//  Created by Skye on 10/9/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "FakeHNItemBuilder.h"

@implementation FakeHNItemBuilder
- (NSArray*)itemFromJSON:(NSString *)objectNotation error:(NSError **)error {
    self.JSON = objectNotation;
    if (error) {
        *error = _errorToSet;
    }
    
    return self.arrayToReturn;
}

@end
