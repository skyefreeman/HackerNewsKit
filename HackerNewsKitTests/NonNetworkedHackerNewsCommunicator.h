//
//  NonNetworkedHackerNewsCommunicator.h
//  HackerNewsKit
//
//  Created by Skye on 10/12/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "HNCommunicator.h"

@interface NonNetworkedHackerNewsCommunicator : HNCommunicator
@property (copy) NSData *receivedData;
@end
