//
//  EssenceViewController.m
//  One
//
//  Created by akkelyn on 16-4-21.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "EssenceViewController.h"
#import "OneTagViewController.h"
#import "OneTopicViewController.h"

@interface EssenceViewController ()<UIScrollViewDelegate>

@property(nonatomic,weak)UIView  *redIndicator;

@property(nonatomic,weak)UIButton *selectedButton;

@property(nonatomic,weak)UIScrollView *scrollView;

@property (nonatomic, weak) UIView *titlesView;
@end

@implementation EssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    [self setChildViewConrtollers];
    [self setUpTitlesView];
    [self setUpContentView];
}
#pragma  mark - 导航栏设置
-(void)setNavigationBar
{
    self.view.backgroundColor = [UIColor colorWithRed:(233)/255.0 green:(233)/255.0 blue:(233)/255.0 alpha:0.7];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
}

#pragma  mark - 设置子控制器
-(void)setChildViewConrtollers
{
    OneTopicViewController *all = [[OneTopicViewController alloc]init];
    all.title = @"全部";
    all.OneType = OneTopicTypeAll;
    [self addChildViewController:all];
    
    OneTopicViewController *video = [[OneTopicViewController alloc]init];
    video.title = @"视频";
    video.OneType = OneTopicTypeVideo;
    [self addChildViewController:video];
    
    OneTopicViewController *voice = [[OneTopicViewController alloc]init];
    voice.title = @"声音";
    voice.OneType = OneTopicTypeVoice;
    [self addChildViewController:voice];
    
    OneTopicViewController *picture = [[OneTopicViewController alloc]init];
    picture.OneType = OneTopicTypePicture;
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    OneTopicViewController *word = [[OneTopicViewController alloc]init];
    word.OneType = OneTopicTypeTypeWord;
    word.title = @"文字";
    [self addChildViewController:word];
    
}
# pragma  mark - 标题师徒设置
-(void)setUpTitlesView
{
    UIView *titlesView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.width ,35)];
    titlesView.backgroundColor = [[UIColor whiteColor]colorWithAlphaComponent:0.9];
    self.titlesView = titlesView;
    [self.view addSubview:titlesView];
   
    UIView *redIndicator = [[UIView alloc]init];
    redIndicator.height = 2;
    redIndicator.y = titlesView.height - redIndicator.height;
    redIndicator.backgroundColor = [UIColor redColor];
    self.redIndicator = redIndicator;
//    [titlesView addSubview:redIndicator];在此处会就添加会影响从self.titleView。subviews中取出按钮因此放到最后加
    NSInteger count = self.childViewControllers.count;
    CGFloat width = self.view.width / count ;
    CGFloat height = titlesView.height;
   
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *tagBtn = [[UIButton alloc]init];
        tagBtn.tag = i;
        tagBtn.width = width;
        tagBtn.height  = height;
        tagBtn.x = i * width;
        OneTopicViewController *vc = self.childViewControllers[i];
        [tagBtn setTitle:vc.title forState:UIControlStateNormal];
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [tagBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [tagBtn setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        [tagBtn layoutIfNeeded];//让titleLable有值
        [tagBtn addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:tagBtn];
        if ( i == 0) {
            [self tagClick:tagBtn];
        }
    }
    [titlesView addSubview:redIndicator];
}
# pragma mark - 标题按钮点击
-(void)tagClick:(UIButton *)tagBtn
{
    self.selectedButton.enabled = YES;
    tagBtn.enabled = NO;
    self.selectedButton = tagBtn;
    [UIView animateWithDuration:0.30 animations:^{
        self.redIndicator.width = tagBtn.titleLabel.width;
        self.redIndicator.centerX = tagBtn.centerX;
    }];
    //让scrollView滚动结束然后添加子控制器的view
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = tagBtn.tag * self.view.width;
    [self.scrollView setContentOffset:offset animated:YES];
}
#pragma  mark - 设置scrollView
-(void)setUpContentView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame =self.view.bounds;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(self.childViewControllers.count * scrollView.width, 0);
    self.scrollView = scrollView;
    [self.view insertSubview:scrollView atIndex:0];
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
#pragma  mark - 左侧按钮点击
-(void)tagClick
{
    OneTagViewController *tagViewcontroller = [[OneTagViewController alloc]init];
    [self.navigationController pushViewController:tagViewcontroller animated:YES];
}
#pragma  mark - UIScrollviewDelegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / self.view.width;
    OneTopicViewController *oneVc = self.childViewControllers[index];
    oneVc.view.x = scrollView.contentOffset.x;
    oneVc.view.y = 0;
    oneVc.view.height = scrollView.height;
   [scrollView addSubview:oneVc.view];
}
#pragma  mark - 手滑动scrollview减速
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:self.scrollView];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self tagClick:self.titlesView.subviews[index]];
}
@end
