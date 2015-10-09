//
//  HNItemBuilder.m
//  HackerNewsKit
//
//  Created by Skye on 10/9/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HNItemBuilder.h"

NSString * ItemBuilderErrorDomain = @"ItemBuilderErrorDomain";

@implementation HNItemBuilder
- (NSArray*)itemFromJSON:(NSString*)objectNotation error:(NSError **)error {
    NSParameterAssert(objectNotation != nil);
    if (error != nil) {
        *error = [NSError errorWithDomain:ItemBuilderErrorDomain
                                     code:ItemBuilderErrorInvalidJSON
                                 userInfo:nil];
    }
    
    return nil;
}

@end
