//
//  FakeURLResponse.m
//  HackerNewsKit
//
//  Created by Skye on 10/12/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "FakeURLResponse.h"

@implementation FakeURLResponse

- (instancetype)initWithStatusCode:(NSInteger)code {
    self = [super init];
    if (!self) return nil;
    
    statusCode = code;
    
    return self;
}

- (NSInteger)statusCode {
    return statusCode;
}

@end
