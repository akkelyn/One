//
//  OneRecommendTag.h
//  Best
//
//  Created by akkelyn on 16-4-22.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
// 左边标签

#import <Foundation/Foundation.h>

@interface OneRecommendTag : NSObject
//"id": "9",
//"name": "电台",
//"count": "78"
@property (nonatomic,assign)NSInteger ID;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)NSInteger count;

/*******************************辅助****************************/

/**保存一个category对应的user模型的数组*/
@property(nonatomic,strong)NSMutableArray *usersArray;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
@end
