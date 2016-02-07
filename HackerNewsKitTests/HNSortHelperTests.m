//
//  HNSortHelperTests.m
//  HackerNewsKit
//
//  Created by Skye on 2/6/16.
//  Copyright © 2016 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HNSortHelper.h"
#import "HNItem.h"

@interface HNSortHelperTests : XCTestCase
{
    NSArray *items;
}
@end

@implementation HNSortHelperTests

- (void)setUp {
    [super setUp];

    HNItem *item3 = [[HNItem alloc] initWithIdentifier:3];
    item3.time = 3;
    
    HNItem *item2 = [[HNItem alloc] initWithIdentifier:2];
    item2.time = 2;
    
    HNItem *item1 = [[HNItem alloc] initWithIdentifier:1];
    item1.time = 1;
    
    items = @[item3,item2,item1];
}

- (void)tearDown {
    items = nil;
    [super tearDown];
}

- (void)testSortHelperSortsItemsToMatchIdentifierList {
    NSArray *identifiers = @[@"1",@"2",@"3"];
    NSArray *sortedItems = [HNSortHelper sortHNItems:items toMatchIdentifiers:identifiers];
    
    HNItem *sortedItem1 = sortedItems[0];
    HNItem *sortedItem2 = sortedItems[1];
    HNItem *sortedItem3 = sortedItems[2];
    
    XCTAssertTrue(sortedItem1.identifier == 1, @"Items were not sorted to match the order of the identifiers");
    XCTAssertTrue(sortedItem2.identifier == 2, @"Items were not sorted to match the order of the identifiers");
    XCTAssertTrue(sortedItem3.identifier == 3, @"Items were not sorted to match the order of the identifiers");
}

- (void)testSortHelperSortsItemsByTime {
    NSArray *sortedItems = [HNSortHelper sortHNItems:items];
    HNItem *sortedItem1 = sortedItems[0];
    HNItem *sortedItem2 = sortedItems[1];
    HNItem *sortedItem3 = sortedItems[2];
    
    XCTAssertTrue(sortedItem1.time == 3, @"Items were not sorted by decreasing time");
    XCTAssertTrue(sortedItem2.time == 2, @"Items were not sorted by decreasing time");
    XCTAssertTrue(sortedItem3.time == 1, @"Items were not sorted by decreasing time");
}

@end
