//
//  HNItemCreationTests.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "HNManager.h"
#import "MockHackerNewsManagerDelegate.h"
#import "MockHackerNewsCommunicator.h"
#import "FakeHNItemBuilder.h"
#import "HNItem.h"

@interface HNItemCreationWorkflowTests : XCTestCase
@end

@implementation HNItemCreationWorkflowTests
{
    HNManager *manager;
    MockHackerNewsManagerDelegate *delegate;
    MockHackerNewsCommunicator *communicator;
    FakeHNItemBuilder *builder;
    
    HNItem *returnedItem;
    NSArray *returnedTopStories;
    
    NSError *underlyingError;
}

- (void)setUp {
    [super setUp];
    
    manager = [[HNManager alloc] init];

    delegate = [[MockHackerNewsManagerDelegate alloc] init];
    manager.delegate = delegate;

    communicator = [[MockHackerNewsCommunicator alloc] init];
    manager.communicator = communicator;
    
    underlyingError = [NSError errorWithDomain:@"Test Domain" code:0 userInfo:nil];
    
    builder = [[FakeHNItemBuilder alloc] init];
    manager.itemBuilder = builder;
    
    returnedItem = [[HNItem alloc] initWithIdentifier:123];
    returnedTopStories = [NSArray arrayWithObject:[[HNItem alloc] initWithIdentifier:123]];
}

- (void)tearDown {
    manager = nil;
    manager.itemBuilder = nil;
    delegate = nil;
    communicator = nil;
    underlyingError = nil;
    builder = nil;
    returnedItem = nil;
    returnedTopStories = nil;
    
    [super tearDown];
}

- (void)testNonConformingObjectCannotBeDelegate {
    XCTAssertThrows(manager.delegate = (id <HNManagerDelegate>)[NSNull null], @"NSNull should not be used as the delegate because it doesnt conform to the delegate protocol.");
}

- (void)testConformingObjectCanBeDelegate {
    XCTAssertNoThrow(manager.delegate = delegate, @"Object conforming to the delegate protocol should be used as the delegate");
}

- (void)testManagerAcceptsNilAsADelegate {
    XCTAssertNoThrow(manager.delegate = nil, @"It should be acceptable to use nil as an objects delegate");
}

- (void)testAskingForTopStoriesMeansRequestingData {
    [manager fetchTopStories];
    XCTAssertTrue([communicator wasAskedToFetchTopStories],@"Asking the communicator for top stories requires fetching data.");
}

- (void)testAskingForItemWithIDMeansRequestingData {
    [manager fetchItemForIdentifier:123];
    XCTAssertTrue([communicator wasAskedToFetchItem], @"Asking the communicator for an item from a item ID requires fetching data ");
}

#pragma mark - Error Testing
- (void)testErrorReturnedToDelegateIsNotErrorNotifiedByCommunicator {
    [manager communicatorTopStoriesFetchFailedWithError:underlyingError];
    XCTAssertFalse(underlyingError == [delegate fetchError],@"Error should be at the correct level of abstraction.");
}

- (void)testErrorReturnedToDelegateByTopStoryFetchDocumentsUnderlyingError {
    [manager communicatorTopStoriesFetchFailedWithError:underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], underlyingError, @"The underlying error should be available to client code when fetching top stories fails");
}

- (void)testErrorReturnedToDelegateByItemFetchDocumentsUnderlyingError {
    [manager communicatorItemFetchFailedWithError:underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey],underlyingError, @"The underlying error should be available to client code when fetching an item fails");
}

- (void)testErrorReturnedToDelegateByNewStoryFetchDocumentsUnderlyingError {
    [manager communicatorNewStoriesFetchFailedWithError:underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey],underlyingError, @"The underlying error should be available to client code when fetching new stories fails");
}

- (void)testErrorReturnedToDelegateByAskStoryFetchDocumentsUnderlyingError {
    [manager communicatorAskStoriesFetchFailedWithError:underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey],underlyingError, @"The underlying error should be available to client code when fetching ask stories fails");
}

- (void)testErrorReturnedToDelegateByShowStoryFetchDocumentsUnderlyingError {
    [manager communicatorShowStoriesFetchFailedWithError:underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey],underlyingError, @"The underlying error should be available to client code when fetching show stories fails");
}

- (void)testErrorReturnedToDelegateByJobStoryFetchDocumentsUnderlyingError {
    [manager communicatorJobStoriesFetchFailedWithError:underlyingError];
    XCTAssertEqualObjects([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey],underlyingError, @"The underlying error should be available to client code when fetching job stories fails");
}

#pragma mark - Item
- (void)testItemJSONIsPassedToItemBuilder {
    [manager recievedItemWithJSON:@"Fake JSON"];
    XCTAssertEqualObjects(builder.JSON, @"Fake JSON",@"Downloaded JSON is sent to the builder");
}

- (void)testDelegateNotifiedOfErrorWhenItemBuilderFailsToMakeAnItem {
    builder.arrayToReturn = nil;
    builder.errorToSet = underlyingError;
    [manager recievedItemWithJSON:@"Fake JSON"];
    XCTAssertNotNil([[[delegate fetchError] userInfo] objectForKey:NSUnderlyingErrorKey], @"The delegate should have found out about the error");
}

- (void)testDelegateNotToldAboutErrorWhenItemRecieved {
    builder.itemToReturn = returnedItem;
    [manager recievedItemWithJSON:@"Fake JSON"];
    XCTAssertNil([delegate fetchError],@"No error should be recieved on success");
}

- (void)testDelegateReceivesTheItemDiscoveredByManager {
    builder.itemToReturn = returnedItem;
    [manager recievedItemWithJSON:@"Fake JSON"];
    XCTAssertEqualObjects([delegate receivedItem], returnedItem, @"The manager should have sent it's questions to the delegate");
}

@end
