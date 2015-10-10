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
@end

static NSString *topStoryURL = @"https://hacker-news.firebaseio.com/v0/topstories";

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

- (void)testFetchingTopStoriesCallsHackerNewsAPI {
    [communicator fetchTopStories];
    NSURL *testURL = [NSURL URLWithString:topStoryURL];
    XCTAssertEqualObjects([communicator URLToFetch], testURL, @"Asking for top stories needs to use the correct URL");
}

- (void)testFetchingAnItemCallsHackerNewsAPI {
    XCTAssertTrue(NO);
}

@end
