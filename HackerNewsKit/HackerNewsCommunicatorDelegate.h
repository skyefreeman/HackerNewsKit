//
//  HackerNewsCommunicatorDelegate.h
//  HackerNewsKit
//
//  Created by Skye on 10/12/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HackerNewsCommunicatorDelegate <NSObject>
- (void)communicatorItemFetchFailedWithError:(NSError*)error;
- (void)communicatorTopStoriesFetchFailedWithError:(NSError*)error;

- (void)communicatorNewStoriesFetchFailedWithError:(NSError*)error;
- (void)communicatorAskStoriesFetchFailedWithError:(NSError*)error;
- (void)communicatorShowStoriesFetchFailedWithError:(NSError*)error;
- (void)communicatorJobStoriesFetchFailedWithError:(NSError*)error;


@end
