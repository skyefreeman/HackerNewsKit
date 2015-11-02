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
    [self.manager fetchShowStories];
}

#pragma mark - HackerNewsManager Delegate
- (void)didReceiveItem:(HNItem *)item {
    NSLog(@"%@",item.title);
}

- (void)didReceiveTopStories:(NSArray *)topStories {
    HNItem *item = [topStories objectAtIndex:0];
    NSLog(@"%@",item.title);
}

- (void)didReceiveAskStories:(NSArray *)askStories {
    HNItem *item = [askStories objectAtIndex:0];
    NSLog(@"%@",item.title);
}
- (void)didReceiveJobStories:(NSArray *)jobStories {
    HNItem *item = [jobStories objectAtIndex:0];
    NSLog(@"%@",item.title);
}

- (void)didReceiveNewStories:(NSArray *)newStories {
    HNItem *item = [newStories objectAtIndex:0];
    NSLog(@"%@",item.title);
}

- (void)didReceiveShowStories:(NSArray *)showStories {
    HNItem *item = [showStories objectAtIndex:0];
    NSLog(@"%@",item.title);
}

- (void)hackerNewsFetchFailedWithError:(NSError *)error {
}

@end
