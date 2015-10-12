//
//  HackerNewsCommunicatorTests.m
//  HackerNewsKit
//
//  Created by Skye on 10/10/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HackerNewsCommunicator.h"
#import "InspectableHackerNewsCommunicator.h"

@interface HackerNewsCommunicatorTests : XCTestCase
- (NSString*)fetchedURLString;
@end

static NSString *testTopStoryURLString = @"https://hacker-news.firebaseio.com/v0/topstories.json";
static NSString *testNewStoryURLString = @"https://hacker-news.firebaseio.com/v0/newstories.json";
static NSString *testAskStoryURLString = @"https://hacker-news.firebaseio.com/v0/askstories.json";
static NSString *testShowStoryURLString = @"https://hacker-news.firebaseio.com/v0/showstories.json";
static NSString *testJobStoryURLString = @"https://hacker-news.firebaseio.com/v0/jobstories.json";
static NSString *testItemURLString = @"https://hacker-news.firebaseio.com/v0/item/123.json";

@implementation HackerNewsCommunicatorTests
{
    InspectableHackerNewsCommunicator *communicator;
}

- (void)setUp {
    [super setUp];
    communicator = [[InspectableHackerNewsCommunicator alloc] init];
}

- (void)tearDown {
    communicator = nil;
    [super tearDown];
}

- (void)testFetchingTopStoriesCallsHackerNewsTopStoryAPI {
    [communicator fetchTopStories];
    XCTAssertEqualObjects([self fetchedURLString], testTopStoryURLString, @"Asking for top stories needs to use the correct URL string");
}

- (void)testFetchingNewStoriesCallsHackerNewsNewStoryAPI {
    [communicator fetchNewStories];
    XCTAssertEqualObjects([self fetchedURLString], testNewStoryURLString, @"Asking for new stories needs to use the correct URL string");
}

- (void)testFetchingAskStoriesCallsHackerNewsAskStoryAPI {
    [communicator fetchAskStories];
    XCTAssertEqualObjects([self fetchedURLString], testAskStoryURLString, @"Asking for ask stories needs to use the correct URL string");
}

- (void)testFetchingShowStoriesCallsHackerNewsShowStoryAPI {
    [communicator fetchShowStories];
    XCTAssertEqualObjects([self fetchedURLString], testShowStoryURLString, @"Asking for show stories needs to use the correct URL string");
}

- (void)testFetchingJobStoriesCallsHackerNewsJobStoryAPI {
    [communicator fetchJobStories];
    XCTAssertEqualObjects([self fetchedURLString], testJobStoryURLString, @"Asking for job stories needs to use the correct URL string");
}

- (void)testFetchingAnItemCallsHackerNewsItemAPI {
    [communicator fetchItemForIdentifier:123];
    XCTAssertEqualObjects([self fetchedURLString], testItemURLString, @"Asking for an individual item needs to construct the correct URL string.");
}

#pragma mark - Convenience
- (NSString*)fetchedURLString {
    return [[communicator URLToFetch] absoluteString];
}

@end
