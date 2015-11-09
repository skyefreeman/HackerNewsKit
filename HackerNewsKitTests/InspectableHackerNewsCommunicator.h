//
//  InspectableHackerNewsCommunicator.h
//  HackerNewsKit
//
//  Created by Skye on 10/10/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HackerNewsCommunicator.h"

@interface InspectableHackerNewsCommunicator : HackerNewsCommunicator
- (NSURL*)URLToFetch;
- (NSURLSession*)currentSession;
- (NSURLSessionDataTask*)currentSessionTask;
@end
