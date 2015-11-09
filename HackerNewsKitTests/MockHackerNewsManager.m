//
//  MockHackerNewsManager.m
//  HackerNewsKit
//
//  Created by Skye on 10/12/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "MockHackerNewsManager.h"

@implementation MockHackerNewsManager

#pragma mark - Error Codes
- (NSInteger)itemFailureErrorCode {
    return itemFailureErrorCode;
}

- (NSInteger)topStoriesFailureErrorCode {
    return topStoriesFailureErrorCode;
}

- (NSInteger)newStoriesFailureErrorCode {
    return newStoriesFailureErrorCode;
}

- (NSInteger)askStoriesFailureErrorCode {
    return askStoriesFailureErrorCode;
}

- (NSInteger)showStoriesFailureErrorCode {
    return showStoriesFailureErrorCode;
}

- (NSInteger)jobStoriesFailureErrorCode {
    return jobStoriesFailureErrorCode;
}

#pragma mark - Successful Fetch Strings
- (NSString*)fetchedItemString {
    return fetchedItemString;
}

- (NSString*)fetchedTopStoryString {
    return fetchedTopStoryString;
}

- (NSString*)fetchedNewStoryString {
    return fetchedNewStoryString;
}

- (NSString*)fetchedAskStoryString {
    return fetchedAskStoryString;
}

- (NSString*)fetchedShowStoryString {
    return fetchedShowStoryString;
}

- (NSString*)fetchedJobsStoryString {
    return fetchedJobsStoryString;
}

#pragma mark - HackerNewsCommunicatorDelegate
- (void)communicatorItemFetchFailedWithError:(NSError *)error {
    itemFailureErrorCode = [error code];
}

- (void)communicatorTopStoriesFetchFailedWithError:(NSError *)error {
    topStoriesFailureErrorCode = [error code];
}

- (void)communicatorNewStoriesFetchFailedWithError:(NSError*)error {
    newStoriesFailureErrorCode = [error code];
}

- (void)communicatorAskStoriesFetchFailedWithError:(NSError*)error {
    askStoriesFailureErrorCode = [error code];
}

- (void)communicatorShowStoriesFetchFailedWithError:(NSError*)error {
    showStoriesFailureErrorCode = [error code];
}

- (void)communicatorJobStoriesFetchFailedWithError:(NSError*)error {
    jobStoriesFailureErrorCode = [error code];
}

- (void)recievedItemWithJSON:(NSString*)objectNotation {
     fetchedItemString = objectNotation;
}

- (void)recievedTopStoriesWithJSON:(NSString *)objectNotation {
    fetchedTopStoryString = objectNotation;
}

- (void)recievedNewStoriesWithJSON:(NSString*)objectNotation {
    fetchedNewStoryString = objectNotation;
}

- (void)recievedAskStoriesWithJSON:(NSString*)objectNotation {
    fetchedAskStoryString = objectNotation;
}

- (void)recievedShowStoriesWithJSON:(NSString*)objectNotation {
    fetchedShowStoryString = objectNotation;
}

- (void)recievedJobsStoriesWithJSON:(NSString*)objectNotation {
    fetchedJobsStoryString = objectNotation;
}


@end
