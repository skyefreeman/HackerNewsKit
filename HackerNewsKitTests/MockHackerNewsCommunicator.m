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
    BOOL wasAskedToFetchItem;
}

#pragma mark - Top Stories
- (BOOL)wasAskedToFetchTopStories {
    return wasAskedToFetchTopStories;
}

- (void)fetchTopStories {
    wasAskedToFetchTopStories = YES;
}

#pragma mark - Item
- (BOOL)wasAskedToFetchItem {
    return wasAskedToFetchItem;
}

- (void)fetchItemForID:(NSString *)ID {
    wasAskedToFetchItem = YES;
}

@end
