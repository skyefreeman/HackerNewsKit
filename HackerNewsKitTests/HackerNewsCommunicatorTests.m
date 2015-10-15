//
//  HackerNewsCommunicatorTests.m
//  HackerNewsKit
//
//  Created by Skye on 10/10/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InspectableHackerNewsCommunicator.h"
#import "NonNetworkedHackerNewsCommunicator.h"
#import "MockHackerNewsManager.h"
#import "FakeURLResponse.h"

@interface HackerNewsCommunicatorTests : XCTestCase
- (NSString*)fetchedURLString;
@end

static NSString *testTopStoryURLString = @"https://hacker-news.firebaseio.com/v0/topstories.json";
static NSString *testNewStoryURLString = @"https://hacker-news.firebaseio.com/v0/newstories.json";
static NSString *testAskStoryURLString = @"https://hacker-news.firebaseio.com/v0/askstories.json";
static NSString *testShowStoryURLString = @"https://hacker-news.firebaseio.com/v0/showstories.json";
static NSString *testJobStoryURLString = @"https://hacker-news.firebaseio.com/v0/jobstories.json";

static NSString *testItemURLString = @"https://hacker-news.firebaseio.com/v0/item/123.json";
static NSInteger testIdentifier = 123;

@implementation HackerNewsCommunicatorTests
{
    InspectableHackerNewsCommunicator *communicator;
    NonNetworkedHackerNewsCommunicator *nnCommunicator;
    MockHackerNewsManager *manager;
    FakeURLResponse *fourOhFourResponse;

    NSData *recievedData;
}

- (void)setUp {
    [super setUp];
    communicator = [[InspectableHackerNewsCommunicator alloc] init];
    nnCommunicator = [[NonNetworkedHackerNewsCommunicator alloc] init];
    manager = [[MockHackerNewsManager alloc] init];
    nnCommunicator.delegate = manager;
    fourOhFourResponse = [[FakeURLResponse alloc] initWithStatusCode:404];
    recievedData = [@"Result" dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)tearDown {
    communicator = nil;
    nnCommunicator = nil;
    manager = nil;
    fourOhFourResponse = nil;
    recievedData = nil;
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
    [communicator fetchItemForIdentifier:testIdentifier];
    XCTAssertEqualObjects([self fetchedURLString], testItemURLString, @"Asking for an individual item needs to construct the correct URL string.");
}

- (void)testFetchingTopStoriesCreatesAURLConnection {
    [communicator fetchTopStories];
    XCTAssertNotNil([communicator currentSessionTask], @"There should be a URL connection");
}

- (void)testStartingNewSearchThrowsOutOldConnection {
    [communicator fetchItemForIdentifier:testIdentifier];
    NSURLSessionDataTask *firstTask = [communicator currentSessionTask];
    [communicator fetchItemForIdentifier:111];
    XCTAssertFalse([[communicator currentSessionTask] isEqual:firstTask], @"The communicator replace a current connection with a new one");
}

- (void)testURLSessionIsTheSameAfterDifferentSessionTasks {
    [communicator fetchAskStories];
    NSURLSession *currentSession = [communicator currentSession];
    [communicator fetchJobStories];
    XCTAssertEqualObjects(currentSession, [communicator currentSession], @"THe communicator should keep the same NSURLSession between dataTasks");
}

- (void)testReceivingResponseDiscardsExistingData {
    nnCommunicator.receivedData = [@"Data" dataUsingEncoding:NSUTF8StringEncoding];
    [nnCommunicator fetchItemForIdentifier:123];
    [self fourOhFourResponseCall];
    XCTAssertEqual([nnCommunicator.receivedData length], (NSUInteger)0, @"Data should have been discarded");
}

- (void)testReceiving404StatusPassesErrorToDelegate {
    [nnCommunicator fetchItemForIdentifier:123];
    [self fourOhFourResponseCall];
    XCTAssertEqual([manager itemFailureErrorCode], 404, @"404 Error code should be passed to the delegate");
}

- (void)testReceiving404StatusForTopStoriesPassesErrorToDelegate {
    [nnCommunicator fetchTopStories];
    [self fourOhFourResponseCall];
    XCTAssertEqual([manager topStoriesFailureErrorCode], 404, @"404 error code should be passed to delegate");
}

- (void)testReceiving404StatusForNewStoriesPassesErrorToDelegate {
    [nnCommunicator fetchNewStories];
    [self fourOhFourResponseCall];
    XCTAssertEqual([manager newStoriesFailureErrorCode], 404, @"404 error code should be passed to delegate");
}

- (void)testReceiving404StatusForAskStoriesPassesErrorToDelegate {
    [nnCommunicator fetchAskStories];
    [self fourOhFourResponseCall];
    XCTAssertEqual([manager askStoriesFailureErrorCode], 404, @"404 error code should be passed to delegate");
}

- (void)testReceiving404StatusForShowStoriesPassesErrorToDelegate {
    [nnCommunicator fetchShowStories];
    [self fourOhFourResponseCall];
    XCTAssertEqual([manager showStoriesFailureErrorCode], 404, @"404 error code should be passed to delegate");
}

- (void)testReceiving404StatusForJobStoriesPassesErrorToDelegate {
    [nnCommunicator fetchJobStories];
    [self fourOhFourResponseCall];
    XCTAssertEqual([manager jobStoriesFailureErrorCode], 404, @"404 error code should be passed to delegate");
}

#pragma mark - Convenience
- (NSString*)fetchedURLString {
    return [[communicator URLToFetch] absoluteString];
}

- (void)fourOhFourResponseCall {
    [nnCommunicator URLSession:[communicator currentSession] dataTask:[communicator currentSessionTask] didReceiveResponse:(NSURLResponse*)fourOhFourResponse completionHandler:^(NSURLSessionResponseDisposition disposition) {}];
}

@end
