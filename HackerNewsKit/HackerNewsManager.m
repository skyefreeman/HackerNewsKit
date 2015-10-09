//
//  HackerNewsManager.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HackerNewsManager.h"

// Builders
#import "HNItemBuilder.h"

// Constants
NSString *HackerNewsManagerError = @"HackerNewsManagerError";

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

- (void)receivedItemJSON:(NSString*)objectNotation {
    NSError *error = nil;
    NSArray *items = [_itemBuilder itemFromJSON:objectNotation error:&error];
    if (!items) {
        [self tellDelegateAboutTopStoryFetchError:error];
    } else {
        [self.delegate didReceiveItems:items];
    }
}

- (void)fetchingTopStoriesFailedWithError:(NSError*)error {
    [self tellDelegateAboutTopStoryFetchError:error];
}

#pragma mark - Convenience
- (void)tellDelegateAboutTopStoryFetchError:(NSError*)error {
    NSDictionary *errorInfo = nil;
    if (error) {
        errorInfo = [NSDictionary dictionaryWithObject:error forKey:NSUnderlyingErrorKey];
    }
    
    NSError *reportableError = [NSError errorWithDomain:HackerNewsManagerError code:HackerNewsManagerErrorCodeTopStories userInfo:errorInfo];
    [self.delegate fetchingTopStoriesFailedWithError:reportableError];
}

@end
