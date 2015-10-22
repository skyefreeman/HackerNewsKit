//
//  HackerNewsManager.h
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HackerNewsManagerDelegate.h"
#import "HackerNewsCommunicatorDelegate.h"

#import "HackerNewsCommunicator.h"
#import "HNItemBuilder.h"

@interface HackerNewsManager : NSObject <HackerNewsCommunicatorDelegate>

@property (nonatomic, weak) id <HackerNewsManagerDelegate> delegate;
@property (strong) HackerNewsCommunicator *communicator;
@property (strong) HNItemBuilder *itemBuilder;

- (void)fetchTopStories;
- (void)fetchItemForIdentifier:(NSInteger)identifier;

@end

extern NSString *HackerNewsManagerError;

typedef NS_ENUM(NSInteger, HackerNewsManagerErrorCode) {
    HackerNewsManagerErrorCodeItem,
    HackerNewsManagerErrorCodeTopStories,
    HackerNewsManagerErrorCodeNewStories,
};

