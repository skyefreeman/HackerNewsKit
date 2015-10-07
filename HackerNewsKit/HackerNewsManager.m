//
//  HackerNewsManager.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HackerNewsManager.h"

@implementation HackerNewsManager

- (void)setDelegate:(id<HackerNewsManagerDelegate>)delegate {
    if (delegate && ![delegate conformsToProtocol:@protocol(HackerNewsManagerDelegate)]) {
        [[NSException exceptionWithName:NSInvalidArgumentException reason:@"Delegate object does not conform to the delegate protocol." userInfo:nil] raise];
    }
    _delegate = delegate;
}

- (void)fetchTopStories {
    [self.communicator fetchTopStories];
}

- (void)fetchingTopStoriesFailedWithError:(NSError*)error {
    NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    NSError *reportableError = [NSError errorWithDomain:HackerNewsManagerError code:HackerNewsManagerErrorCodeTopStories userInfo:errorInfo];
    [self.delegate fetchingTopStoriesFailedWithError:reportableError];
}
@end

NSString *HackerNewsManagerError = @"HackerNewsManagerError";