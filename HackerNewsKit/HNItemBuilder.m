//
//  HNItemBuilder.m
//  HackerNewsKit
//
//  Created by Skye on 10/9/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HNItemBuilder.h"
#import "HNItem.h"

NSString * ItemBuilderErrorDomain = @"ItemBuilderErrorDomain";

@interface HNItemBuilder()
- (HNItem*)itemFromDictionary:(NSDictionary*)dict;
@end

@implementation HNItemBuilder
- (NSArray*)itemsFromJSONArray:(NSString*)objects error:(NSError **)error {
    return nil;
}

- (HNItem*)itemFromJSON:(NSString*)objectNotation error:(NSError **)error {
    NSParameterAssert(objectNotation != nil);
    
    NSData *unicodeNotation = [objectNotation dataUsingEncoding:NSUTF8StringEncoding];
    NSError *localError = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options:0 error:&localError];
    NSDictionary *parsedObject = (id)jsonObject;
    
    if (parsedObject == nil) {
        if (error != nil) {
            *error = [NSError errorWithDomain:ItemBuilderErrorDomain
                                         code:ItemBuilderErrorInvalidJSON
                                     userInfo:nil];
        }
        return nil;
    }
    
    HNItem *item = [self itemFromDictionary:parsedObject];
    if (item == nil) {
        if (error != nil) {
            *error = [NSError errorWithDomain:ItemBuilderErrorDomain
                                         code:ItemBuilderErrorMissingData
                                     userInfo:nil];
        }
        return nil;
    }
    
    return nil;
}

#pragma mark - Class Continuation
- (HNItem*)itemFromDictionary:(NSDictionary*)dict {
    HNItem *item = [[HNItem alloc] initWithID:[dict objectForKey:@"id"]];
    return item;
}

@end
