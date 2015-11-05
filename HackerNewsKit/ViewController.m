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

@implementation ViewController {
    BOOL didFetch;
    BOOL didFetchAgain;
    NSMutableArray *cachedTopStories;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    cachedTopStories = [[NSMutableArray alloc] init];
    
    self.manager = [[HackerNewsManager alloc] init];
    self.manager.delegate = self;
    
    [self.manager fetchTopStories];
//    [self.manager fetchMore];
}

#pragma mark - HackerNewsManager Delegate
- (void)didReceiveItem:(HNItem *)item {

}

- (void)didReceiveTopStories:(NSArray *)topStories {
    [cachedTopStories addObjectsFromArray:topStories];
    NSLog(@"%lu",cachedTopStories.count);
}

- (void)didReceiveAskStories:(NSArray *)askStories {
    NSLog(@"%lu",askStories.count);
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
    NSLog(@"%@",error);
}

@end
