//
//  MockHackerNewsManager.h
//  HackerNewsKit
//
//  Created by Skye on 10/12/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HNManager.h"

@interface MockHackerNewsManager : HNManager {
    NSInteger itemFailureErrorCode;
    NSInteger topStoriesFailureErrorCode;
    NSInteger newStoriesFailureErrorCode;
    NSInteger askStoriesFailureErrorCode;
    NSInteger showStoriesFailureErrorCode;
    NSInteger jobStoriesFailureErrorCode;
    
    NSString *fetchedItemString;
    NSString *fetchedTopStoryString;
    NSString *fetchedNewStoryString;
    NSString *fetchedAskStoryString;
    NSString *fetchedShowStoryString;
    NSString *fetchedJobsStoryString;
}

- (NSInteger)itemFailureErrorCode;
- (NSInteger)topStoriesFailureErrorCode;
- (NSInteger)newStoriesFailureErrorCode;
- (NSInteger)askStoriesFailureErrorCode;
- (NSInteger)showStoriesFailureErrorCode;
- (NSInteger)jobStoriesFailureErrorCode;

- (NSString*)fetchedItemString;
- (NSString*)fetchedTopStoryString;
- (NSString*)fetchedNewStoryString;
- (NSString*)fetchedAskStoryString;
- (NSString*)fetchedShowStoryString;
- (NSString*)fetchedJobsStoryString;

@end
