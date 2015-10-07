//
//  HNItemCreationTests.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "HackerNewsManager.h"
#import "MockHackerNewsManagerDelegate.h"
#import "MockHackerNewsCommunicator.h"

@interface HNItemCreationTests : XCTestCase
@end

@implementation HNItemCreationTests
{
    HackerNewsManager *manager;
    MockHackerNewsManagerDelegate *delegate;
    MockHackerNewsCommunicator *communicator;
    
    NSError *underlyingError;
}

- (void)setUp {
    [super setUp];
    
    manager = [[HackerNewsManager alloc] init];
    delegate = [[MockHackerNewsManagerDelegate alloc] init];
    manager.delegate = delegate;
    
    communicator = [[MockHackerNewsCommunicator alloc] init];
    manager.communicator = communicator;
    
    underlyingError = [NSError errorWithDomain:@"Test Domain" code:0 userInfo:nil];
}

- (void)tearDown {
    manager = nil;
    delegate = nil;
    communicator = nil;
    underlyingError = nil;
    
    [super tearDown];
}

- (void)testNonConformingObjectCannotBeDelegate {
    XCTAssertThrows(manager.delegate = (id <HackerNewsManagerDelegate>)[NSNull null], @"NSNull should not be used as the delegate because it doesnt conform to the delegate protocol.");
}

- (void)testConformingObjectCanBeDelegate {
    XCTAssertNoThrow(manager.delegate = delegate, @"Object conforming to the delegate protocol should be used as the delegate");
}

- (void)testManagerAcceptsNilAsADelegate {
    XCTAssertNoThrow(manager.delegate = nil, @"It should be acceptable to use nil as an objects delegate");
}

- (void)testAskingForTopStoriesMeansRequestingData {
    [manager fetchTopStories];
    XCTAssertTrue([communicator wasAskedToFetchTopStories],@"The communicator should need to fetch data.");
}

- (void)testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator {
    [manager fetchingTopStoriesFailedWithError:underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError],@"Error should be at the correct level of abstraction.");
}

- (void)testErrorReturnedToDelegateDocumentsUnderlyingError {
    [manager fetchingTopStoriesFailedWithError:underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], underlyingError, @"The underlying error should be available to client code");
}

@end
