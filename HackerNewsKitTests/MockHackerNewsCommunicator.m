//
//  MockHackerNewsCommunicator.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "MockHackerNewsCommunicator.h"

@implementation MockHackerNewsCommunicator
{
    BOOL wasAskedToFetchTopStories;
}

- (BOOL)wasAskedToFetchTopStories {
    return wasAskedToFetchTopStories;
}

- (void)fetchTopStories {
    wasAskedToFetchTopStories = YES;
}

@end
