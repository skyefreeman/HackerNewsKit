//
//  HNItemBuilderTests.m
//  HackerNewsKit
//
//  Created by Skye on 10/9/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HNItemBuilder.h"

@interface HNItemBuilderTests : XCTestCase
@end

static NSString *noIDJSONString = @"{ \"noID\": true }";

@implementation HNItemBuilderTests
{
    HNItemBuilder *itemBuilder;
}

- (void)setUp {
    [super setUp];
    itemBuilder = [[HNItemBuilder alloc] init];
}

- (void)tearDown {
    itemBuilder = nil;

    [super tearDown];
}

#pragma mark - Items

#pragma mark - Item
- (void)testThatNilIsNotAnAcceptableParameter {
    XCTAssertThrows([itemBuilder itemFromJSON:nil error:nil], @"Lack of data needs to be handled");
}

- (void)testNilReturnedWhenStringIsNotJSON {
    XCTAssertNil([itemBuilder itemFromJSON:@"Not JSON" error:nil],@"This variable should not be parseable");
}

- (void)testErrorSetWhenStringIsNotJSON {
    NSError *error = nil;
    [itemBuilder itemFromJSON:@"" error:&error];
    XCTAssertNotNil(error,@"We should be told when an error occurs");
}

- (void)testPassingNilErrorDoesNotCauseCrash {
    XCTAssertNoThrow([itemBuilder itemFromJSON:@"Not JSON" error:nil]);
}

- (void)testRealJSONWithoutIDReturnsMissingDataError {
    NSError *error = nil;
    [itemBuilder itemFromJSON:noIDJSONString error:&error];
    XCTAssertEqual([error code], ItemBuilderErrorMissingData, @"This case needs to specify the it was correct json, but was missing the correct data");
}

@end
