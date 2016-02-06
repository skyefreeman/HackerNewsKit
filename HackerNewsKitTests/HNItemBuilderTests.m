//
//  HNItemBuilderTests.m
//  HackerNewsKit
//
//  Created by Skye on 10/9/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "HNItemBuilder.h"
#import "HNItem.h"

@interface HNItemBuilderTests : XCTestCase
@end

static NSString *noIDJSONString = @"{ \"noID\": true }";
static NSString *IDJSONString = @"{ \"id\": 123 }";

static NSString *storyJSONString = @"{"
@" \"by\" : \"dhouston\","
@" \"descendants\" : 71,"
@" \"id\" : 8863,"
@" \"kids\" : [8934, 8876],"
@" \"parts\" : [8934, 8876],"
@" \"score\" : 111,"
@" \"time\" : 1175714200,"
@" \"parent\" : 12345,"
@" \"title\" : \"My YC app: Dropbox - Throw away your USB drive\","
@" \"type\" : \"story\","
@" \"dead\" : \"false\","
@" \"text\" : \"testing text\","
@" \"url\" : \"http://www.getdropbox.com/u/2/screencast.html\""
@"}";

@implementation HNItemBuilderTests
{
    HNItemBuilder *itemBuilder;
    HNItem *item;
}

- (void)setUp {
    [super setUp];
    itemBuilder = [[HNItemBuilder alloc] init];
    item = [itemBuilder itemFromJSON:storyJSONString error:nil];
}

- (void)tearDown {
    itemBuilder = nil;
    item = nil;
    
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

- (void)testRealJSONWithoutIDReturnsMissingDataError {
    NSError *error = nil;
    [itemBuilder itemFromJSON:noIDJSONString error:&error];
    XCTAssertEqual([error code], ItemBuilderErrorMissingData, @"This case needs to specify the it was correct json, but was missing the correct data");
}

- (void)testThatRealStoryJSONCreatesHNItem {
    XCTAssertNotNil(item,@"Real story JSON should create a HNItem");
}

- (void)testThatAnItemIsBuiltCorrectly {
    XCTAssertTrue(item.identifier == 8863, @"Item 'identifier' should be parsed correctly");
    XCTAssertTrue([item.type isEqualToString:@"story"], @"Item 'type' should be parsed correctly");
    XCTAssertTrue([item.by isEqualToString:@"dhouston"], @"Item 'by' should be parsed correctly");
    XCTAssertTrue([item.text isEqualToString:@"testing text"], @"Item 'text' should be parsed correctly");
    XCTAssertTrue([item.url isEqualToString:@"http://www.getdropbox.com/u/2/screencast.html"], @"Item 'url' should be parsed correctly");
    XCTAssertTrue([item.title isEqualToString:@"My YC app: Dropbox - Throw away your USB drive"], @"Item 'title' should be parsed correctly");
    XCTAssertTrue(item.time == 1175714200, @"Item 'time' should be parsed correctly");
    XCTAssertTrue(item.parent == 12345, @"Item 'parent' should be parsed correctly");
    XCTAssertTrue(item.descendants == 71, @"Item 'descendants' should be parsed correctly");
    XCTAssertTrue(item.score == 111, @"Item 'score' should be parsed correctly");
    
    NSArray *testArray = @[@8934, @8876];
    XCTAssertTrue([item.kids isEqual:testArray], @"Item 'kids' should be parsed correctly");
    XCTAssertTrue([item.parts isEqual:testArray], @"Item 'parts' should be parsed correctly");
}

- (void)testThatNilCantBePassedAsItems {
    XCTAssertThrows([itemBuilder itemsFromJSONArray:nil error:nil], @"Lack of data needs to be handled");
}

- (void)testThatItemsAreParsedIntoAnArray {
    NSArray *jsonArray = @[IDJSONString];
    NSArray *itemArray = [itemBuilder itemsFromJSONArray:jsonArray error:nil];
    XCTAssertTrue([[itemArray firstObject] isKindOfClass:[HNItem class]],@"Should turn array of json objects into an array of Hacker news item objects");
}

- (void)testThatTwoJSONItemsTurnsIntoTwoHNItems {
    NSArray *jsonArray = @[storyJSONString,storyJSONString];
    NSArray *itemArray = [itemBuilder itemsFromJSONArray:jsonArray error:nil];
    XCTAssertEqual(itemArray.count, jsonArray.count, @"Two JSON items should be parsed into two HN Items");
}

- (void)testPassingNilJSONObjectDoesNotBuildNilHNItem {
    NSError *error = nil;
    NSArray *array = [itemBuilder itemsFromJSONArray:@[[NSNull null]] error:&error];
    XCTAssertTrue(array.count == 0,  @"Built array created an HNItem when it should not have");
}

@end
