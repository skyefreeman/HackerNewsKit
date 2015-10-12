//
//  MockHackerNewsManager.h
//  HackerNewsKit
//
//  Created by Skye on 10/12/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HackerNewsManager.h"

@interface MockHackerNewsManager : HackerNewsManager {
    NSInteger itemFailureErrorCode;
}

- (NSInteger)itemFailureErrorCode;

@end
