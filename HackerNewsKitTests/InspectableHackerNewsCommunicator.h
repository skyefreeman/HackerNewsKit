//
//  InspectableHackerNewsCommunicator.h
//  HackerNewsKit
//
//  Created by Skye on 10/10/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HNCommunicator.h"

@interface InspectableHackerNewsCommunicator : HNCommunicator
- (NSURL*)URLToFetch;
- (NSURLSession*)currentSession;
- (NSURLSessionDataTask*)currentSessionTask;
@end
