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

- (NSError*)reportableErrorFromError:(NSError*)error domain:(NSString*)errorDomain code:(NSInteger)errorCode;
- (NSDictionary*)errorInfoFromError:(NSError*)error;

@end

@implementation HackerNewsManager

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.communicator = [[HackerNewsCommunicator alloc] init];
    self.communicator.delegate = self;
    
    self.itemBuilder = [[HNItemBuilder alloc] init];
    
    return self;
}

- (void)setDelegate:(id<HackerNewsManagerDelegate>)delegate {
    if (delegate && ![delegate conformsToProtocol:@protocol(HackerNewsManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol." userInfo:nil] raise];
    }
    _delegate = delegate;
}

#pragma mark - Stories
- (void)fetchTopStories {
    [self.communicator fetchTopStories];
}

- (void)fetchItemForIdentifier:(NSInteger)identifier {
    [self.communicator fetchItemForIdentifier:identifier];
}

#pragma mark - HackerNewsCommunicator Delegate
- (void)communicatorItemFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutItemFetchError:error];
}

- (void)communicatorTopStoriesFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutTopStoriesFetchError:error];
}

- (void)communicatorNewStoriesFetchFailedWithError:(NSError*)error {
}

- (void)communicatorAskStoriesFetchFailedWithError:(NSError*)error {
}

- (void)communicatorShowStoriesFetchFailedWithError:(NSError*)error {
}

- (void)communicatorJobStoriesFetchFailedWithError:(NSError*)error {
}

- (void)recievedItemWithJSON:(NSString *)objectNotation {
    NSError *error = nil;
    HNItem *item  = [_itemBuilder itemFromJSON:objectNotation error:&error];
    if (!item) {
        [self tellDelegateAboutItemFetchError:error];
    } else {
        [self.delegate didReceiveItem:item];
    }
}

- (void)recievedTopStoriesWithJSON:(NSString *)objectNotation {
//    NSError *error = nil;
//    NSArray *topStories = [_itemBuilder itemsFromJSONArray:JSONArray error:&error];
//    if (!topStories) {
//        [self tellDelegateAboutTopStoriesFetchError:error];
//    } else {
//        [self.delegate didReceiveTopStories:topStories];
//    }
}

- (void)recievedNewStoriesWithJSON:(NSString *)objectNotation {
}

- (void)recievedAskStoriesWithJSON:(NSString *)objectNotation {
}

- (void)recievedShowStoriesWithJSON:(NSString *)objectNotation {
}

- (void)recievedJobsStoriesWithJSON:(NSString *)objectNotation {
}


#pragma mark - Class Continuation
- (void)tellDelegateAboutItemFetchError:(NSError*)error {
    NSError *reportableError = [self reportableErrorFromError:error domain:HackerNewsManagerError code:HackerNewsManagerErrorCodeItem];
    [self.delegate hackerNewsItemFetchFailedWithError:reportableError];
}

- (void)tellDelegateAboutTopStoriesFetchError:(NSError*)error {
    NSError *reportableError = [self reportableErrorFromError:error domain:HackerNewsManagerError code:HackerNewsManagerErrorCodeTopStories];
    [self.delegate hackerNewsTopStoriesFetchFailedWithError:reportableError];
}

- (void)tellDelegateAboutNewStoriesFetchError:(NSError*)error {
}

- (void)tellDelegateAboutAskStoriesFetchError:(NSError*)error {
}

- (void)tellDelegateAboutShowStoriesFetchError:(NSError*)error {
}

- (void)tellDelegateAboutJobStoriesFetchError:(NSError*)error {
}

- (NSError*)reportableErrorFromError:(NSError*)error domain:(NSString*)errorDomain code:(NSInteger)errorCode {
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
