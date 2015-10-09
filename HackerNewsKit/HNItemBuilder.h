//
//  HNItemBuilder.h
//  HackerNewsKit
//
//  Created by Skye on 10/9/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNItemBuilder : NSObject
- (NSArray*)itemFromJSON:(NSString*)objectNotation error:(NSError **)error;

@end

extern NSString * ItemBuilderErrorDomain;

typedef NS_ENUM(NSInteger, ItemBuilderError) {
    ItemBuilderErrorInvalidJSON,
};