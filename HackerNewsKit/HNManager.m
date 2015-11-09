//
//  HackerNewsManager.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HNManager.h"

// Builders
#import "HNItemBuilder.h"

// Constants
NSString *HackerNewsManagerError = @"HackerNewsManagerError";
NSInteger const kMaxFetchCount = 30;

typedef NS_ENUM(NSInteger, ItemFetchType) {
    ItemFetchTypeTopStories,
    ItemFetchTypeNewStories,
    ItemFetchTypeAskStories,
    ItemFetchTypeShowStories,
    ItemFetchTypeJobStories,
};

@interface HNManager ()

// Cached Properties
@property (nonatomic, copy) NSString *cachedItemJSON;
@property (nonatomic) ItemFetchType cachedItemFetchType;
@property (nonatomic) NSInteger fetchStartIndex;

// Fetching Queued Items
- (void)getItemsForItemIdentifiers:(NSArray*)itemIDs withSuccess:(void (^)(NSArray *))completion;
- (void)getItemsForJSON:(NSString*)itemJSON withSuccess:(void (^)(NSArray *itemObjects))completion;

// Error Reporting
- (void)tellDelegateAboutFetchError:(NSError*)error;
- (void)tellDelegateAboutPaginationError;

- (NSError*)reportableErrorFromError:(NSError*)error domain:(NSString*)errorDomain code:(NSInteger)errorCode;
- (NSDictionary*)errorInfoFromError:(NSError*)error;

// Convenience
- (NSArray*)arrayFromJSON:(NSString*)objectNotation;

@end

@implementation HNManager

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.communicator = [[HNCommunicator alloc] init];
    self.communicator.delegate = self;
    
    self.itemBuilder = [[HNItemBuilder alloc] init];
    
    return self;
}

- (void)setDelegate:(id<HNManagerDelegate>)delegate {
    if (delegate && ![delegate conformsToProtocol:@protocol(HNManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol." userInfo:nil] raise];
    }
    _delegate = delegate;
}

#pragma mark - Stories
- (void)fetchItemForIdentifier:(NSInteger)identifier {
    [self.communicator fetchItemForIdentifier:identifier];
}

- (void)fetchTopStories {
    self.cachedItemFetchType = ItemFetchTypeTopStories;
    [self.communicator fetchTopStories];
}

- (void)fetchNewStories {
    self.cachedItemFetchType = ItemFetchTypeNewStories;
    [self.communicator fetchNewStories];
}

- (void)fetchAskStories {
    self.cachedItemFetchType = ItemFetchTypeAskStories;
    [self.communicator fetchAskStories];
}

- (void)fetchShowStories {
    self.cachedItemFetchType = ItemFetchTypeShowStories;
    [self.communicator fetchShowStories];
}

- (void)fetchJobStories {
    self.cachedItemFetchType = ItemFetchTypeJobStories;
    [self.communicator fetchJobStories];
}

- (void)fetchNextStories {
    if (self.cachedItemJSON == nil) {
        [self tellDelegateAboutPaginationError];
        return;
    }
    
    self.fetchStartIndex += kMaxFetchCount;
    
    switch (self.cachedItemFetchType) {
        case ItemFetchTypeTopStories: {
            [self recievedTopStoriesWithJSON:self.cachedItemJSON];
            break;
        }
        case ItemFetchTypeNewStories: {
            [self recievedNewStoriesWithJSON:self.cachedItemJSON];
            break;
        }
        case ItemFetchTypeAskStories: {
            [self recievedAskStoriesWithJSON:self.cachedItemJSON];
            break;
        }
        case ItemFetchTypeShowStories: {
            [self recievedShowStoriesWithJSON:self.cachedItemJSON];
            break;
        }
        case ItemFetchTypeJobStories: {
            [self recievedJobsStoriesWithJSON:self.cachedItemJSON];
            break;
        }
    }
}

#pragma mark - Setter Override
- (void)setCachedItemFetchType:(ItemFetchType)cachedItemFetchType {
    self.fetchStartIndex = 0;
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
    [self getItemsForJSON:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveTopStories:itemObjects];
    }];
}

- (void)recievedNewStoriesWithJSON:(NSString *)objectNotation {
    [self getItemsForJSON:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveNewStories:itemObjects];
    }];
}

- (void)recievedAskStoriesWithJSON:(NSString *)objectNotation {
    [self getItemsForJSON:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveAskStories:itemObjects];
    }];
}

- (void)recievedShowStoriesWithJSON:(NSString *)objectNotation {
    [self getItemsForJSON:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveShowStories:itemObjects];
    }];
}

- (void)recievedJobsStoriesWithJSON:(NSString *)objectNotation {
    [self getItemsForJSON:objectNotation withSuccess:^(NSArray *itemObjects) {
        [self.delegate didReceiveJobStories:itemObjects];
    }];
}

#pragma mark - Item Fetch + Building
- (void)getItemsForJSON:(NSString*)itemJSON withSuccess:(void (^)(NSArray *itemObjects))successHandler {
    self.cachedItemJSON = itemJSON;
    NSArray *itemIdentifiers = [self arrayFromJSON:itemJSON];
    [self getItemsForItemIdentifiers:itemIdentifiers withSuccess:successHandler];
}

- (void)getItemsForItemIdentifiers:(NSArray*)itemIDs withSuccess:(void (^)(NSArray *))successHandler {
    NSInteger remainingItemIDs = itemIDs.count - _fetchStartIndex;
    NSInteger fetchableItemCount = (remainingItemIDs > 0) ? remainingItemIDs : 0;
    NSInteger fetchCount = (remainingItemIDs > kMaxFetchCount) ? kMaxFetchCount : fetchableItemCount;
    
    [self performItemRequestsWithItemIdentifiers:itemIDs withCount:fetchCount startIndex:_fetchStartIndex withCompletion:^(NSArray *itemObjects) {
        NSError *error = nil;
        NSArray *builtItems = [_itemBuilder itemsFromJSONArray:itemObjects error:&error];
        if (!builtItems) {
            [self tellDelegateAboutFetchError:error];
        } else {
            if (successHandler) successHandler(builtItems);
        }
    }];
}

- (void)performItemRequestsWithItemIdentifiers:(NSArray *)itemIDs
                                     withCount:(NSInteger)itemCount
                                    startIndex:(NSInteger)startIndex
                                withCompletion:(void (^)(NSArray *itemObjects))completion
{
    NSMutableArray *itemObjects = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger i = startIndex; i < (startIndex + itemCount); i++) {
        
        dispatch_group_enter(group);
        NSString *IDString = itemIDs[i];
        HNCommunicator *communicator = [[HNCommunicator alloc] init];
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

- (void)tellDelegateAboutPaginationError {
    NSError *error = [NSError errorWithDomain:HackerNewsManagerError code:HackerNewsManagerErrorCodePagination userInfo:nil];
    [self.delegate hackerNewsFetchFailedWithError:error];
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
