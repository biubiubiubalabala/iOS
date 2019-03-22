//
//  ViewController.m
//  手势解锁CALayer
//
//  Created by 李斯然 on 2019/3/19.
//  Copyright © 2019年 siranlee. All rights reserved.
//

#import "ViewController.h"
#import "UnlockView.h"
#import "UIView+FrameExtension.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UnlockView *UnlockView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景
    self.view.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"Home_refresh_bg"].CGImage);
//    //创建一个UnlockView用于画图
    //直接在storyBoard里创建视图
//    UnlockView * lockView = [[UnlockView alloc]initWithFrame:CGRectMake(0, (self.view.height-self.view.width)/2.0, self.view.width, self.view.width)];
//    lockView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:lockView];
}
#pragma mark - 添加按钮






@end
