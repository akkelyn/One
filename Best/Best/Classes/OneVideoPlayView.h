//
//  OneVideoPlayView.h
//  Best
//
//  Created by akkelyn on 16-5-4.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol OneVideoPlayViewDelegate <NSObject>

@optional
- (void)videoplayViewSwitchOrientation:(BOOL)isFull;

@end

@interface OneVideoPlayView : UIView

+ (instancetype)videoPlayView;

@property (weak, nonatomic) id<OneVideoPlayViewDelegate> delegate;

@property (nonatomic, strong) AVPlayerItem *playerItem;
@end
