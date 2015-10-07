//
//  MockHackerNewsManagerDelegate.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "MockHackerNewsManagerDelegate.h"

@implementation MockHackerNewsManagerDelegate
- (void)fetchingTopStoriesFailedWithError:(NSError *)error {
    self.fetchError = error;
}
@end
