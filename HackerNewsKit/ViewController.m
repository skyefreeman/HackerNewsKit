//
//  ViewController.m
//  HackerNewsKit
//
//  Created by Skye on 10/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "ViewController.h"
#import "HackerNewsManager.h"
#import "HNItem.h"

@interface ViewController () <HackerNewsManagerDelegate>
@property (nonatomic) HackerNewsManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.manager = [[HackerNewsManager alloc] init];
    self.manager.delegate = self;
    
    [self.manager fetchTopStories];
}

#pragma mark - HackerNewsManager Delegate
- (void)didReceiveItem:(HNItem *)item {
    NSLog(@"%@",item);
}

- (void)didReceiveTopStories:(NSArray *)topStories {
    NSLog(@"%@",topStories);
}

- (void)didReceiveAskStories:(NSArray *)askStories {
    NSLog(@"%@",askStories);
}

- (void)didReceiveJobStories:(NSArray *)jobStories {
    NSLog(@"%@",jobStories);
}

- (void)didReceiveNewStories:(NSArray *)newStories {
    NSLog(@"%@",newStories);
}

- (void)didReceiveShowStories:(NSArray *)showStories {
    NSLog(@"%@",showStories);
}

- (void)hackerNewsFetchFailedWithError:(NSError *)error {
    NSLog(@"%@",error);
}

@end
