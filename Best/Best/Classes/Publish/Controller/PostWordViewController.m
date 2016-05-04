//
//  PostWordViewController.m
//  Best
//
//  Created by akkelyn on 16-4-26.
//  Copyright (c) 2016年 akkelyn. All rights reserved.
//

#import "PostWordViewController.h"
#import "PlaceHolderTextView.h"
#import "AddTagToolbar.h"


@interface PostWordViewController ()<UITextViewDelegate>

@property(nonatomic,weak)PlaceHolderTextView *textView;

@property(nonatomic,weak)AddTagToolbar *toolbar;
@end

@implementation PostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //导航栏
    self.title = @"发表文字";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded];
    //文本输入框
    PlaceHolderTextView *textView = [[PlaceHolderTextView alloc] init];
    textView.placeholder = @"把好玩的图片，好笑的段子或糗事发到这里！";
    textView.frame = self.view.bounds;
    textView.delegate = self;
    [self.view addSubview:textView];
    self.textView = textView;
    
    //工具条
    AddTagToolbar *toolbar = [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([AddTagToolbar class]) owner:nil options:nil] lastObject];
    toolbar.width = self.view.width;
    toolbar.y = self.view.height - toolbar.height;
    self.toolbar = toolbar;
    [self.view addSubview:toolbar];
    [OneNoteCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.toolbar.transform = CGAffineTransformMakeTranslation(0,  keyboardF.origin.y - OneScreenH);
    }];
}
-(void)cancel
{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)post
{

}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view endEditing:YES];
    [self.textView becomeFirstResponder];
}

#pragma mark - <UITextViewDelegate>
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
@end
