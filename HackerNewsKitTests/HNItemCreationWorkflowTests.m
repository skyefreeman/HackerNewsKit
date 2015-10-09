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
#import "FakeHNItemBuilder.h"
#import "HNItem.h"

@interface HNItemCreationWorkflowTests : XCTestCase
@end

@implementation HNItemCreationWorkflowTests
{
    HackerNewsManager *manager;
    MockHackerNewsManagerDelegate *delegate;
    MockHackerNewsCommunicator *communicator;
    FakeHNItemBuilder *builder;
    NSArray *itemArray;
    
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
    
    builder = [[FakeHNItemBuilder alloc] init];
    manager.itemBuilder = builder;
    
    HNItem *item = [[HNItem alloc] initWithID:@"123"];
    itemArray = [NSArray arrayWithObject:item];
}

- (void)tearDown {
    manager = nil;
    manager.itemBuilder = nil;
    delegate = nil;
    communicator = nil;
    underlyingError = nil;
    builder = nil;
    itemArray = nil;
    
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

- (void)testItemJSONIsPassedToItemBuilder {
    [manager receivedItemJSON:@"Fake JSON"];
    XCTAssertEqualObjects(builder.JSON, @"Fake JSON",@"Downloaded JSON is sent to the builder");
}

- (void)testDelegateNotifiedOfErrorWhenItemBuilderFails {
    builder.arrayToReturn = nil;
    builder.errorToSet = underlyingError;
    
    [manager receivedItemJSON:@"Fake JSON"];
    
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"The delegate should have found out about the error");
}

- (void)testDelegateNotToldAboutErrorWhenItemRecieved {
    builder.arrayToReturn = itemArray;
    [manager receivedItemJSON:@"Fake JSON"];
    XCTAssertNil([delegate fetchError],@"No error should be recieved on success");
}

- (void)testDelegateReceivesTheItemDiscoveredByManager {
    builder.arrayToReturn = itemArray;
    [manager receivedItemJSON:@"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedItems], itemArray, @"The manager should have sent it's questions to the delegate");
}

- (void)testEmptyArrayIsPassedToDelegate {
    builder.arrayToReturn = [NSArray array];
    [manager receivedItemJSON:@"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedItems], [NSArray array],@"Returning an empty array is not an error");
}

@end
