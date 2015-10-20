//
//  ViewController.m
//  HackerNewsKit
//
//  Created by Skye on 10/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "ViewController.h"
#import "HackerNewsCommunicator.h"

@interface ViewController () <HackerNewsCommunicatorDelegate>
@property (nonatomic) HackerNewsCommunicator *communicator;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.communicator = [[HackerNewsCommunicator alloc] init];
    [self.communicator fetchItemForIdentifier:14];
}

@end
