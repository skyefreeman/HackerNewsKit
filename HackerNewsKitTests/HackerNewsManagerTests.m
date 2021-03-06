//
//  HackerNewsManagerTests.m
//  HackerNewsKit
//
//  Created by Skye on 10/21/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HNManager.h"
#import "HNCommunicator.h"

@interface HackerNewsManagerTests : XCTestCase
@end

@implementation HackerNewsManagerTests {
    HNManager *manager;
}

- (void)setUp {
    [super setUp];
    manager = [[HNManager alloc] init];
}

- (void)tearDown {
    manager = nil;
    [super tearDown];
}

- (void)testInitializingSetsCommunicatorDelegate {
    XCTAssertNotNil(manager.communicator.delegate, @"HackerNewsManager needs to set the HackerNewsCommunicator delegate during init");
}

- (void)testInitializingSetsItemBuilder {
    XCTAssertNotNil(manager.itemBuilder, @"HackerNewsManager needs to create an HNItemBuilder during init");
}

@end
