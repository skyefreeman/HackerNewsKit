//
//  NonNetworkedHackerNewsCommunicator.m
//  HackerNewsKit
//
//  Created by Skye on 10/12/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "NonNetworkedHackerNewsCommunicator.h"

@implementation NonNetworkedHackerNewsCommunicator

- (void)setReceivedData:(NSData *)data {
    receivedData = [data copy];
}

- (NSMutableData*)receivedData {
    return receivedData;
}

@end
