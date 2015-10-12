//
//  HackerNewsCommunicator.h
//  HackerNewsKit
//
//  Created by Skye on 10/7/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HackerNewsCommunicator : NSObject {
@protected
    NSURL *fetchingURL;
}

- (void)fetchTopStories;
- (void)fetchNewStories;
- (void)fetchAskStories;
- (void)fetchShowStories;
- (void)fetchJobStories;
- (void)fetchItemForIdentifier:(NSInteger)identifier;

@end
