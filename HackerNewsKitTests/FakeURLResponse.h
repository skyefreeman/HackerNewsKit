//
//  FakeURLResponse.h
//  HackerNewsKit
//
//  Created by Skye on 10/12/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FakeURLResponse : NSObject {
    NSInteger statusCode;
}

- (instancetype)initWithStatusCode:(NSInteger)code;
- (NSInteger)statusCode;

@end
