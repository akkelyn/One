//
//  OneCommentHeaderView.h
//  Best
//
//  Created by akkelyn on 16-4-25.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OneCommentHeaderView : UITableViewHeaderFooterView
/** 文字数据 */
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
