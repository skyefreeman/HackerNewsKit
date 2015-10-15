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

- (void)tellDelegateAboutItemFetchError:(NSError*)error;
- (void)tellDelegateAboutTopStoriesFetchError:(NSError*)error;
- (void)tellDelegateAboutNewStoriesFetchError:(NSError*)error;
- (void)tellDelegateAboutAskStoriesFetchError:(NSError*)error;
- (void)tellDelegateAboutShowStoriesFetchError:(NSError*)error;
- (void)tellDelegateAboutJobStoriesFetchError:(NSError*)error;

- (NSError*)reportablErrorFromError:(NSError*)error domain:(NSString*)errorDomain code:(NSInteger)errorCode;
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
- (void)communicatorItemFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutItemFetchError:error];
}

- (void)communicatorTopStoriesFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutTopStoriesFetchError:error];
}

- (void)communicatorNewStoriesFetchFailedWithError:(NSError*)error {
    
}
//

- (void)communicatorAskStoriesFetchFailedWithError:(NSError*)error {
    
}

- (void)communicatorShowStoriesFetchFailedWithError:(NSError*)error {
    
}

- (void)communicatorJobStoriesFetchFailedWithError:(NSError*)error {
    
}

// Will be refactored
- (void)fetchTopStories {
    [self.communicator fetchTopStories];
}

- (void)fetchItemForIdentifier:(NSInteger)identifier {
    [self.communicator fetchItemForIdentifier:identifier];
}


#pragma mark - Items
- (void)receivedTopStoriesJSON:(NSArray*)JSONArray {
    NSError *error = nil;
    NSArray *topStories = [_itemBuilder itemsFromJSONArray:JSONArray error:&error];
    if (!topStories) {
        [self tellDelegateAboutTopStoriesFetchError:error];
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
    [self tellDelegateAboutTopStoriesFetchError:error];
}

#pragma mark - Class Continuation
- (void)tellDelegateAboutItemFetchError:(NSError*)error {
    NSError *reportableError = [self reportablErrorFromError:error domain:HackerNewsManagerError code:HackerNewsManagerErrorCodeItem];
    [self.delegate fetchingTopStoriesFailedWithError:reportableError];
}

- (void)tellDelegateAboutTopStoriesFetchError:(NSError*)error {
    NSError *reportableError = [self reportablErrorFromError:error domain:HackerNewsManagerError code:HackerNewsManagerErrorCodeTopStories];
    [self.delegate fetchingTopStoriesFailedWithError:reportableError];
}

- (void)tellDelegateAboutNewStoriesFetchError:(NSError*)error {
    NSError *reportableError = [self reportablErrorFromError:error domain:HackerNewsManagerError code:HackerNewsManagerErrorCodeNewStories];
    
}

- (void)tellDelegateAboutAskStoriesFetchError:(NSError*)error {
}

- (void)tellDelegateAboutShowStoriesFetchError:(NSError*)error {
}

- (void)tellDelegateAboutJobStoriesFetchError:(NSError*)error {
}

- (NSError*)reportablErrorFromError:(NSError*)error domain:(NSString*)errorDomain code:(NSInteger)errorCode {
    NSDictionary *errorInfo = [self errorInfoFromError:error];
    return [NSError errorWithDomain:errorDomain code:errorCode userInfo:errorInfo];
}

- (NSDictionary*)errorInfoFromError:(NSError*)error {
    if (error) {
        return [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    }
    return nil;
}

@end
