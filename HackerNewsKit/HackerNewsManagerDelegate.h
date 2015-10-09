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
- (void)fetchingTopStoriesFailedWithError:(NSError*)error;
- (void)fetchingItemFailedWithError:(NSError*)error;

- (void)didReceiveTopStories:(NSArray*)topStories;
- (void)didReceiveItem:(HNItem*)item;
@end
