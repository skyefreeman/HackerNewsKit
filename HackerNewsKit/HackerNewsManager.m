//
//  HackerNewsManager.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HackerNewsManager.h"

// Builders
#import "HNItemBuilder.h"

// Constants
NSString *HackerNewsManagerError = @"HackerNewsManagerError";

@interface HackerNewsManager ()

- (void)tellDelegateAboutTopStoryFetchError:(NSError*)error;
- (void)tellDelegateAboutItemFetchError:(NSError*)error;
- (NSDictionary*)errorInfoFromError:(NSError*)error;

@end

@implementation HackerNewsManager

- (void)setDelegate:(id<HackerNewsManagerDelegate>)delegate {
    if (delegate && ![delegate conformsToProtocol:@protocol(HackerNewsManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol." userInfo:nil] raise];
    }
    _delegate = delegate;
}

#pragma mark - Hacker News Communicator
- (void)fetchTopStories {
    [self.communicator fetchTopStories];
}

- (void)fetchItemForID:(NSString *)ID {
    [self.communicator fetchItemForID:ID];
}

#pragma mark - Items
- (void)receivedTopStoriesJSON:(NSArray*)JSONArray {
    NSError *error = nil;
    NSArray *topStories = [_itemBuilder itemsFromJSONArray:JSONArray error:&error];
    if (!topStories) {
        [self tellDelegateAboutTopStoryFetchError:error];
    } else {
        [self.delegate didReceiveTopStories:topStories];
    }
}

- (void)receivedItemJSON:(NSString*)objectNotation {
    NSError *error = nil;
    HNItem *item  = [_itemBuilder itemFromJSON:objectNotation error:&error];
    if (!item) {
        [self tellDelegateAboutItemFetchError:error];
    } else {
        [self.delegate didReceiveItem:item];
    }
}

- (void)fetchingTopStoriesFailedWithError:(NSError*)error {
    [self tellDelegateAboutTopStoryFetchError:error];
}

#pragma mark - Class Continuation
- (void)tellDelegateAboutItemFetchError:(NSError*)error {
    NSDictionary *errorInfo = [self errorInfoFromError:error];
    
    NSError *reportableError = [NSError errorWithDomain:HackerNewsManagerError code:HackerNewsManagerErrorCodeItem userInfo:errorInfo];
    [self.delegate fetchingTopStoriesFailedWithError:reportableError];
}

- (void)tellDelegateAboutTopStoryFetchError:(NSError*)error {
    NSDictionary *errorInfo = [self errorInfoFromError:error];
    
    NSError *reportableError = [NSError errorWithDomain:HackerNewsManagerError code:HackerNewsManagerErrorCodeTopStories userInfo:errorInfo];
    [self.delegate fetchingTopStoriesFailedWithError:reportableError];
}

- (NSDictionary*)errorInfoFromError:(NSError*)error {
    if (error) {
        return [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    }
    return nil;
}

@end
