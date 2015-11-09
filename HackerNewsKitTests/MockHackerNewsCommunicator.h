//
//  MockHackerNewsCommunicator.h
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HNCommunicator.h"

@interface MockHackerNewsCommunicator : HNCommunicator

- (BOOL)wasAskedToFetchTopStories;
- (BOOL)wasAskedToFetchItem;

@end
