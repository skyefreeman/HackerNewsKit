//
//  ViewController.m
//  HackerNewsKit
//
//  Created by Skye on 10/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import "ViewController.h"
#import "HackerNewsKit.h"

@interface ViewController () <HNManagerDelegate>
@property (nonatomic) HNManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.manager = [[HNManager alloc] init];
    self.manager.delegate = self;
    
    [self.manager fetchTopStories];
//    [self.manager fetchNewStories];
//    [self.manager fetchJobStories];
}

#pragma mark - HackerNewsManager Delegate
- (void)didReceiveItem:(HNItem *)item {
    NSLog(@"%@",item);
}

- (void)didReceiveTopStories:(NSArray *)topStories {
    for (HNItem *item in topStories) {
        NSLog(@"%@",item.title);
    }
    
    NSLog(@"%@",topStories);
}

- (void)didReceiveAskStories:(NSArray *)askStories {
    NSLog(@"%@",askStories);
}

- (void)didReceiveJobStories:(NSArray *)jobStories {
    NSLog(@"%@",jobStories);
}

- (void)didReceiveNewStories:(NSArray *)newStories {
    for (HNItem *item in newStories) {
        NSLog(@"%@",item.title);
    }
    
    NSLog(@"%@",newStories);
}

- (void)didReceiveShowStories:(NSArray *)showStories {
    NSLog(@"%@",showStories);
}

- (void)didReceiveItemComments:(NSArray *)commentItems {
    NSLog(@"%@",commentItems);
    [self.manager fetchNextStories];
}

- (void)hackerNewsFetchFailedWithError:(NSError *)error {
    NSLog(@"%@",error);
}

@end
