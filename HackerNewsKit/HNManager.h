//
//  HackerNewsManager.h
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNManagerDelegate.h"
#import "HNCommunicatorDelegate.h"

#import "HNCommunicator.h"
#import "HNItemBuilder.h"

@interface HNManager : NSObject <HNCommunicatorDelegate>

@property (nonatomic, weak) id <HNManagerDelegate> delegate;
@property (strong) HNCommunicator *communicator;
@property (strong) HNItemBuilder *itemBuilder;

- (void)fetchItemForIdentifier:(NSInteger)identifier;
- (void)fetchTopStories;
- (void)fetchNewStories;
- (void)fetchAskStories;
- (void)fetchShowStories;
- (void)fetchJobStories;

- (void)fetchNextStories;

@end

extern NSString *HackerNewsManagerError;

typedef NS_ENUM(NSInteger, HackerNewsManagerErrorCode) {
    HackerNewsManagerErrorCodeFetch,
    HackerNewsManagerErrorCodePagination,
};

