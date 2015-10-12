//
//  HackerNewsCommunicator.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HackerNewsCommunicator.h"

static NSString *topStoryURLString = @"https://hacker-news.firebaseio.com/v0/topstories.json";
static NSString *newStoryURLString = @"https://hacker-news.firebaseio.com/v0/newstories.json";
static NSString *askStoryURLString = @"https://hacker-news.firebaseio.com/v0/askstories.json";
static NSString *showStoryURLString = @"https://hacker-news.firebaseio.com/v0/showstories.json";
static NSString *jobStoryURLString = @"https://hacker-news.firebaseio.com/v0/jobstories.json";

static NSString *baseItemURLString = @"https://hacker-news.firebaseio.com/v0/item/";

@interface HackerNewsCommunicator()
- (void)fetchContentAtURL:(NSURL*)url;
- (NSURL*)itemURLWithIdentifier:(NSInteger)itemID;
@end

@implementation HackerNewsCommunicator
- (void)fetchTopStories {
    [self fetchContentAtURL:[NSURL URLWithString:topStoryURLString]];
}

- (void)fetchNewStories {
    [self fetchContentAtURL:[NSURL URLWithString:newStoryURLString]];
}

- (void)fetchAskStories {
    [self fetchContentAtURL:[NSURL URLWithString:askStoryURLString]];
}

- (void)fetchShowStories {
    [self fetchContentAtURL:[NSURL URLWithString:showStoryURLString]];
}

- (void)fetchJobStories {
    [self fetchContentAtURL:[NSURL URLWithString:jobStoryURLString]];
}

- (void)fetchItemForIdentifier:(NSInteger)identifier {
    [self fetchContentAtURL:[self itemURLWithIdentifier:identifier]];
}

#pragma mark - Class Continuation
- (void)fetchContentAtURL:(NSURL *)url {
    fetchingURL = url;
}

- (NSURL*)itemURLWithIdentifier:(NSInteger)itemID {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%lu.json",baseItemURLString,itemID]];
}

@end
