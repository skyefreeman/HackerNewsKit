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

- (void)didReceiveItem:(HNItem *)item {
    NSLog(@"%@",item.title);
}

- (void)didReceiveTopStories:(NSArray *)topStories {
    NSLog(@"%@",topStories);
}

- (void)hackerNewsItemFetchFailedWithError:(NSError *)error {
}

- (void)hackerNewsTopStoriesFetchFailedWithError:(NSError *)error {
}
@end
