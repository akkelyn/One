//
//  OneRecommendTag.m
//  Best
//
//  Created by akkelyn on 16-4-22.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "OneRecommendTag.h"

#import <MJExtension.h>
@implementation OneRecommendTag


- (NSMutableArray *)usersArray
{
    if (!_usersArray) {
        _usersArray = [NSMutableArray array];
    }
    return _usersArray;
}
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"ID" : @"id"};
}
@end
