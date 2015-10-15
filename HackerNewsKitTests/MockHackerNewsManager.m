//
//  MockHackerNewsManager.m
//  HackerNewsKit
//
//  Created by Skye on 10/12/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "MockHackerNewsManager.h"

@implementation MockHackerNewsManager

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

@end
