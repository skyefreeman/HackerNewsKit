//
//  HNItemBuilder.h
//  HackerNewsKit
//
//  Created by Skye on 10/9/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HNItem;

@interface HNItemBuilder : NSObject

- (NSArray*)itemsFromJSONArray:(NSArray*)itemArray error:(NSError **)error;
- (HNItem*)itemFromJSON:(NSString*)objectNotation error:(NSError **)error;

@end

extern NSString * ItemBuilderErrorDomain;

typedef NS_ENUM(NSInteger, ItemBuilderError) {
    ItemBuilderErrorInvalidJSON,
    ItemBuilderErrorMissingData,
};