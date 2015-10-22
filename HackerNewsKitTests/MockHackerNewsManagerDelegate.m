//
//  MockHackerNewsManagerDelegate.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "MockHackerNewsManagerDelegate.h"

@implementation MockHackerNewsManagerDelegate
- (void)hackerNewsTopStoriesFetchFailedWithError:(NSError *)error {
    self.fetchError = error;
}

- (void)hackerNewsItemFetchFailedWithError:(NSError *)error {
    self.fetchError = error;
}

- (void)didReceiveTopStories:(NSArray *)topStories {
    self.receivedTopStories = topStories;
}

- (void)didReceiveItem:(HNItem *)item {
    self.receivedItem = item;
}

@end
