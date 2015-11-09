//
//  MockHackerNewsManagerDelegate.h
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HNManagerDelegate.h"
#import "HNItem.h"

@interface MockHackerNewsManagerDelegate : NSObject <HNManagerDelegate>
@property (strong) NSError *fetchError;
@property (strong) NSArray *receivedTopStories;
@property (strong) HNItem *receivedItem;
@end
