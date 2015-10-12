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

extern NSString *HackerNewsManagerError;

typedef NS_ENUM(NSInteger, HackerNewsManagerErrorCode) {
    HackerNewsManagerErrorCodeItem,
    HackerNewsManagerErrorCodeTopStories,
};

@interface HackerNewsManager : NSObject <HackerNewsCommunicatorDelegate>

@property (nonatomic, weak) id <HackerNewsManagerDelegate> delegate;
@property (strong) HackerNewsCommunicator *communicator;
@property (strong) HNItemBuilder *itemBuilder;

- (void)fetchTopStories;
- (void)fetchItemForIdentifier:(NSInteger)identifier;

//
- (void)receivedItemJSON:(NSString*)objectNotation;
- (void)receivedTopStoriesJSON:(NSArray*)JSONArray;
- (void)fetchingTopStoriesFailedWithError:(NSError*)error;
//
@end
