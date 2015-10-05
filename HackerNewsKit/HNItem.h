//
//  HNItem.h
//  HackerNewsKit
//
//  Created by Skye on 10/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNItem : NSObject 

- (instancetype)initWithID:(NSString*)ID;

@property (nonatomic) NSString *ID;

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *by;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;

@property (nonatomic) NSInteger time;
@property (nonatomic) NSInteger parent;
@property (nonatomic) NSInteger descendants;
@property (nonatomic) NSInteger score;

@property (nonatomic) NSArray *kids;
@property (nonatomic) NSArray *parts;

@property (nonatomic) BOOL deleted;
@property (nonatomic) BOOL dead;

@end
