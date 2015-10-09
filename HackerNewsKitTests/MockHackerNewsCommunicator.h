//
//  MockHackerNewsCommunicator.h
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HackerNewsCommunicator.h"

@interface MockHackerNewsCommunicator : HackerNewsCommunicator

- (BOOL)wasAskedToFetchTopStories;
- (BOOL)wasAskedToFetchItem;

@end
