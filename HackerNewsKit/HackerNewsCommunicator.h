//
//  HackerNewsCommunicator.h
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HackerNewsCommunicatorDelegate.h"

@interface HackerNewsCommunicator : NSObject <NSURLSessionDataDelegate> {
@protected
    NSURL *fetchingURL;
    NSURLSession *session;
    NSURLSessionDataTask *fetchingTask;
    NSMutableData *receivedData;
@private
    id <HackerNewsCommunicatorDelegate> __weak delegate;
    void (^errorHandler)(NSError *);
    void (^successHandler)(NSString *);
}

@property (nonatomic, weak) id <HackerNewsCommunicatorDelegate> delegate;

- (void)fetchTopStories;
- (void)fetchNewStories;
- (void)fetchAskStories;
- (void)fetchShowStories;
- (void)fetchJobStories;
- (void)fetchItemForIdentifier:(NSInteger)identifier;

@end
