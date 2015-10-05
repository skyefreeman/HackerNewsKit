//
//  HNItem.h
//  HackerNewsKit
//
//  Created by Skye on 10/5/15.
//  Copyright © 2015 Skye Freeman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HNItem : NSObject <NSCoding>

- (instancetype)initWithID:(NSString*)ID;

@property (copy) NSString *ID;

@property (copy) NSString *type;
@property (copy) NSString *by;
@property (copy) NSString *text;
@property (copy) NSString *url;
@property (copy) NSString *title;

@property NSInteger time;
@property NSInteger parent;
@property NSInteger descendants;
@property NSInteger score;

@property NSArray *kids;
@property NSArray *parts;

@property (getter=isDeleted) BOOL deleted;
@property (getter=isDead) BOOL dead;

@end
