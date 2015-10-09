//
//  MockHackerNewsManagerDelegate.h
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HackerNewsManagerDelegate.h"

@interface MockHackerNewsManagerDelegate : NSObject <HackerNewsManagerDelegate>
@property (strong) NSError *fetchError;
@property (strong) NSArray *receivedItems;
@end
