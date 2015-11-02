//
//  HackerNewsManagerDelegate.h
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HNItem;

@protocol HackerNewsManagerDelegate <NSObject>
- (void)hackerNewsFetchFailedWithError:(NSError*)error;

- (void)didReceiveTopStories:(NSArray*)topStories;
- (void)didReceiveNewStories:(NSArray*)newStories;
- (void)didReceiveAskStories:(NSArray*)askStories;
- (void)didReceiveShowStories:(NSArray*)showStories;
- (void)didReceiveJobStories:(NSArray*)jobStories;
- (void)didReceiveItem:(HNItem*)item;
@end
