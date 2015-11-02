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
NSInteger const kMaxFetchCount = 30;

@interface HackerNewsManager ()

- (void)getItems:(NSString*)items withSuccess:(void (^)(NSArray *itemObjects))completion;

- (NSArray*)arrayFromJSON:(NSString*)objectNotation;

- (void)tellDelegateAboutFetchError:(NSError*)error;
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
- (void)fetchItemForIdentifier:(NSInteger)identifier {
    [self.communicator fetchItemForIdentifier:identifier];
}

- (void)fetchTopStories {
    [self.communicator fetchTopStories];
}

- (void)fetchNewStories {
    [self.communicator fetchNewStories];
}

- (void)fetchAskStories {
    [self.communicator fetchAskStories];
}

- (void)fetchShowStories {
    [self.communicator fetchShowStories];
}

- (void)fetchJobStories {
    [self.communicator fetchJobStories];
}

#pragma mark - HackerNewsCommunicator Delegate
- (void)communicatorItemFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutFetchError:error];
}

- (void)communicatorTopStoriesFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutFetchError:error];
}

- (void)communicatorNewStoriesFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutFetchError:error];
}

- (void)communicatorAskStoriesFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutFetchError:error];
}

- (void)communicatorShowStoriesFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutFetchError:error];
}

- (void)communicatorJobStoriesFetchFailedWithError:(NSError *)error {
    [self tellDelegateAboutFetchError:error];
}

- (void)recievedItemWithJSON:(NSString *)objectNotation {
    NSError *error = nil;
    HNItem *item  = [_itemBuilder itemFromJSON:objectNotation error:&error];
    if (!item) {
        [self tellDelegateAboutFetchError:error];
    } else {
        [self.delegate didReceiveItem:item];
    }
}

- (void)recievedTopStoriesWithJSON:(NSString *)objectNotation {
    [self getItems:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveTopStories:itemObjects];
    }];
}

- (void)recievedNewStoriesWithJSON:(NSString *)objectNotation {
    [self getItems:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveNewStories:itemObjects];
    }];
}

- (void)recievedAskStoriesWithJSON:(NSString *)objectNotation {
    [self getItems:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveAskStories:itemObjects];
    }];
}

- (void)recievedShowStoriesWithJSON:(NSString *)objectNotation {
    [self getItems:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveShowStories:itemObjects];
    }];
}

- (void)recievedJobsStoriesWithJSON:(NSString *)objectNotation {
    [self getItems:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveJobStories:itemObjects];
    }];
}

#pragma mark - Item Fetch + Building
- (void)getItems:(NSString*)items withSuccess:(void (^)(NSArray *itemObjects))completion {
    NSArray *itemIdentifiers = [self arrayFromJSON:items];
    NSInteger fetchCount = (itemIdentifiers.count > kMaxFetchCount) ? kMaxFetchCount : itemIdentifiers.count;
    [self performItemRequestsWithItemIdentifiers:itemIdentifiers withCount:fetchCount withCompletion:^(NSArray *itemObjects) {
        NSError *error = nil;
        NSArray *builtItems = [_itemBuilder itemsFromJSONArray:itemObjects error:&error];
        if (!builtItems) {
            [self tellDelegateAboutFetchError:error];
        } else {
            if (completion) completion(builtItems);
        }
    }];
}

- (void)performItemRequestsWithItemIdentifiers:(NSArray *)itemIDs
                                     withCount:(NSInteger)itemCount
                                withCompletion:(void (^)(NSArray *itemObjects))completion
{
    NSMutableArray *itemObjects = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();
    for (int i = 0; i < itemCount; i++) {
        
        dispatch_group_enter(group);
        NSString *IDString = itemIDs[i];
        HackerNewsCommunicator *communicator = [[HackerNewsCommunicator alloc] init];
        [communicator fetchItemForIdentifier:[IDString integerValue] completion:^(NSString *objectNotation, NSError *error) {
            if (objectNotation) {
                [itemObjects addObject:objectNotation];
            }
            dispatch_group_leave(group);
        }];
    }

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (completion) completion([NSArray arrayWithArray:itemObjects]);
    });
}

#pragma mark - Error Handling
- (void)tellDelegateAboutFetchError:(NSError*)error {
    NSError *reportableError = [self reportableErrorFromError:error domain:HackerNewsManagerError code:HackerNewsManagerErrorCodeFetch];
    [self.delegate hackerNewsFetchFailedWithError:reportableError];
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

#pragma mark - Convenience 
- (NSArray*)arrayFromJSON:(NSString*)objectNotation {
    NSError *localError = nil;
    NSData *unicodeNotation = [objectNotation dataUsingEncoding: NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:unicodeNotation options: 0 error:&localError];
    return [NSArray arrayWithArray:jsonObject];
}

@end
