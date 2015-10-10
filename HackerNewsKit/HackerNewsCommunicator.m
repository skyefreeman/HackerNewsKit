//
//  HackerNewsCommunicator.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HackerNewsCommunicator.h"

static NSString *topStoryURLString = @"https://hacker-news.firebaseio.com/v0/topstories";

@interface HackerNewsCommunicator()
- (void)fetchContentAtURL:(NSURL*)url;
@end

@implementation HackerNewsCommunicator
- (void)fetchTopStories {
    NSURL *topStoryURL = [NSURL URLWithString:topStoryURLString];
    [self fetchContentAtURL:topStoryURL];
}

#pragma mark - Class Continuation
- (void)fetchContentAtURL:(NSURL *)url {
    fetchingURL = url;
}

@end
