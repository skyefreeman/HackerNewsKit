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

@end
