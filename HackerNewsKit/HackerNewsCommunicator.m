//
//  HackerNewsCommunicator.m
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HackerNewsCommunicator.h"

static NSString *baseItemURLString = @"https://hacker-news.firebaseio.com/v0/item/";
static NSString *topStoryURLString = @"https://hacker-news.firebaseio.com/v0/topstories.json";
static NSString *newStoryURLString = @"https://hacker-news.firebaseio.com/v0/newstories.json";
static NSString *askStoryURLString = @"https://hacker-news.firebaseio.com/v0/askstories.json";
static NSString *showStoryURLString = @"https://hacker-news.firebaseio.com/v0/showstories.json";
static NSString *jobStoryURLString = @"https://hacker-news.firebaseio.com/v0/jobstories.json";

@interface HackerNewsCommunicator()
- (void)fetchContentAtURL:(NSURL *)url errorHandler:(void(^)(NSError *error))errorBlock successHandler:(void(^)(NSString *objectNotation))successBlock;
- (void)launchRequest:(NSURLRequest*)request;
- (NSURL*)itemURLWithIdentifier:(NSInteger)itemID;
@end

@implementation HackerNewsCommunicator

@synthesize delegate;

- (void)fetchTopStories {
    [self fetchContentAtURL:[NSURL URLWithString:topStoryURLString] errorHandler:^(NSError *error) {
        [delegate communicatorTopStoriesFetchFailedWithError:error];
    } successHandler:^(NSString *objectNotation) {
        [delegate recievedTopStoriesWithJSON:objectNotation];
    }];
}

- (void)fetchNewStories {
    [self fetchContentAtURL:[NSURL URLWithString:newStoryURLString] errorHandler:^(NSError *error) {
        [delegate communicatorNewStoriesFetchFailedWithError:error];
    } successHandler:^(NSString *objectNotation) {
        [delegate recievedNewStoriesWithJSON:objectNotation];
    }];
}

- (void)fetchAskStories {
    [self fetchContentAtURL:[NSURL URLWithString:askStoryURLString] errorHandler:^(NSError *error) {
        [delegate communicatorAskStoriesFetchFailedWithError:error];
    } successHandler:^(NSString *objectNotation) {
        [delegate recievedAskStoriesWithJSON:objectNotation];
    }];
}

- (void)fetchShowStories {
    [self fetchContentAtURL:[NSURL URLWithString:showStoryURLString] errorHandler:^(NSError *error) {
        [delegate communicatorShowStoriesFetchFailedWithError:error];
    } successHandler:^(NSString *objectNotation) {
        [delegate recievedShowStoriesWithJSON:objectNotation];
    }];
}

- (void)fetchJobStories {
    [self fetchContentAtURL:[NSURL URLWithString:jobStoryURLString] errorHandler:^(NSError *error) {
        [delegate communicatorJobStoriesFetchFailedWithError:error];
    } successHandler:^(NSString *objectNotation) {
        [delegate recievedJobsStoriesWithJSON:objectNotation];
    }];
}

- (void)fetchItemForIdentifier:(NSInteger)identifier {
    [self fetchContentAtURL:[self itemURLWithIdentifier:identifier] errorHandler:^(NSError *error) {
        [delegate communicatorItemFetchFailedWithError:error];
    } successHandler:^(NSString *objectNotation) {
        [delegate recievedItemWithJSON:objectNotation];
    }];
}

#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    receivedData = nil;
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    if ([httpResponse statusCode] != 200) {
        NSError *error = [NSError errorWithDomain:HackerNewsCommunicatorError code:[httpResponse statusCode] userInfo:nil];
        errorHandler(error);
        [fetchingTask cancel];
    } else {
        receivedData = [[NSMutableData alloc] init];
        completionHandler(NSURLSessionResponseAllow);
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [receivedData appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        errorHandler(error);
    } else {
        NSString *recievedText = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
        receivedData = nil;
        successHandler(recievedText);
    }
}

#pragma mark - Class Continuation
- (void)fetchContentAtURL:(NSURL *)url
             errorHandler:(void(^)(NSError *error))errorBlock
           successHandler:(void(^)(NSString *objectNotation))successBlock {
    fetchingURL = url;
    errorHandler = [errorBlock copy];
    successHandler = [successBlock copy];
    NSURLRequest *request = [NSURLRequest requestWithURL:fetchingURL];
    [self launchRequest:request];
}

- (void)launchRequest:(NSURLRequest*)request {
    if (!session) {
        session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    }
    
    [fetchingTask cancel];
    fetchingTask = [session dataTaskWithRequest:request];
    [fetchingTask resume];
}

- (NSURL*)itemURLWithIdentifier:(NSInteger)itemID {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%lu.json",baseItemURLString,itemID]];
}

@end

NSString *HackerNewsCommunicatorError = @"HackerNewsCommunicatorError";