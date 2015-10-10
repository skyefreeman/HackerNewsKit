//
//  InspectableHackerNewsCommunicator.m
//  HackerNewsKit
//
//  Created by Skye on 10/10/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "InspectableHackerNewsCommunicator.h"

@implementation InspectableHackerNewsCommunicator
- (NSURL*)URLToFetch {
    return fetchingURL;
}
@end
