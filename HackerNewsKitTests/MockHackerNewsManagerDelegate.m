//
//  MockHackerNewsManagerDelegate.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "MockHackerNewsManagerDelegate.h"

@implementation MockHackerNewsManagerDelegate

#pragma mark - Error
- (void)hackerNewsFetchFailedWithError:(NSError *)error {
    self.fetchError = error;
}

#pragma mark - Success
- (void)didReceiveTopStories:(NSArray *)topStories {
    self.receivedTopStories = topStories;
}

- (void)didReceiveItem:(HNItem *)item {
    self.receivedItem = item;
}

@end
