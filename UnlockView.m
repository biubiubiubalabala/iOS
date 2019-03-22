//
//  UnlockView.m
//  手势解锁CALayer
//
//  Created by 李斯然 on 2019/3/19.
//  Copyright © 2019年 siranlee. All rights reserved.
//

#import "UnlockView.h"
//按钮之间的间距
#define kPadding ((self.frame.size.width-3*74)/4.0)
@interface UnlockView()
//把最后一个当做起始点
/**数组*/
@property (nonatomic,strong)NSMutableArray * selectedArray;
/**移动过程中手的最后的触摸点*/
@property (nonatomic,assign)CGPoint lastPoint;
/**记录滑动中的密码*/
/**不能用copy因为拷贝出来的是不可变的*/
@property (nonatomic,strong)NSMutableString * pwdString;
/**label*/
@property (nonatomic,strong)UILabel * titleLabel;
/***/
@property (nonatomic,copy)NSString * oldPassword;
/**<#注释#>*/
@property (nonatomic,copy)NSString * firstString;
@end
@implementation UnlockView
//NSUerdefaults 保存少量数据
-(void)awakeFromNib{
    //存数据
//    [NSUserDefaults standardUserDefaults]setObject:<#(nullable id)#> forKey:<#(nonnull NSString *)#>];
    //取数据就像字典用键值
    self.selectedArray = [NSMutableArray array];
    self.pwdString = [NSMutableString string];
    self.titleLabel = [self viewWithTag:10];
    self.oldPassword = [[NSUserDefaults standardUserDefaults]objectForKey:@"pwd"];
    if (!self.oldPassword) {
        //请绘制密码
        self.titleLabel.text = @"请设置图案密码";
        
    }else{
        //有密码啦，请输入密码
        self.titleLabel.text = @"请绘制密码";
    }

    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    for(int i =0;i<9;i++){
        
       //创建按钮对象
        UIButton * button = [[UIButton alloc]initWithFrame:CGRectZero];
        //设置图片
        [button setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"gesture_node_selected"] forState:UIControlStateSelected];
        //关闭按钮的交互能力
        button.userInteractionEnabled = NO;
        button.tag = i;
        [self addSubview:button];
    }
}
//如果控件是通过storyboard或者xib来创建的
//需要自己添加的控件的frame可能获取不及时的或者不正确
//需要在layoutView里面来设置
-(void)layoutSubviews{
    for(int i = 1;i<self.subviews.count;i++){
        UIButton * button = [self.subviews objectAtIndex:i];
        //确定是第几列
        int column = (i-1)%3;
        int row = (i-1)/3;
        button.frame = CGRectMake(kPadding+(74+kPadding)*column, kPadding+(74+kPadding)*row, 74, 74);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸点坐标
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    //判断某一个点是否在区域内
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, location)) {
            //设置按钮的状态
            button.selected = YES;
            [self.selectedArray addObject:button];
            //记录密码
            [self.pwdString appendFormat:@"%d",(int)button.tag];
        }
    }
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //获取触摸点坐标
    UITouch * touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    //保存当前手的触摸点
    self.lastPoint = location;
    //刷新界面
    //相当于触发drawRect方法
    //告诉系统需要drawRect方法，
    //不是立刻刷新，屏幕刷新的时候被调用
    [self setNeedsDisplay];
    //判断某一个点是否在区域内
    for (UIButton *button in self.subviews) {
        if (CGRectContainsPoint(button.frame, location)) {
            if (button.selected==NO) {
                //设置按钮的状态
                button.selected = YES;
                [self.selectedArray addObject:button];
                //记录密码
                [self.pwdString appendFormat:@"%d",(int)button.tag];
            }
        }
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.oldPassword.length>0) {
        if ([_oldPassword isEqualToString:self.pwdString]) {
            self.titleLabel.text = @"解锁成功";
        }else{
            self.titleLabel.text = @"解锁失败，请重新绘制";
        }
    }else{
        if (self.firstString.length==0) {
            self.firstString = [NSString stringWithString:self.pwdString];
            self.titleLabel.text = @"请确认刚刚绘制的密码图案";
        }else{
            if (![self.firstString isEqualToString:self.pwdString]) {
                self.titleLabel.text = @"两次密码绘制不相同，请重新绘制";
                self.firstString = @"";
            }else{
                self.titleLabel.text = @"密码设置成功";
                [[NSUserDefaults standardUserDefaults]setObject:self.firstString forKey:@"pwd"];
            }
        }
    }
    
    //现将所有点亮的按钮的状态改变一下
    for (UIButton * button in self.selectedArray) {
        button.selected = NO;
    }
    //i清空数组
    [self.selectedArray removeAllObjects];
    //刷新屏幕
    [self setNeedsDisplay];
    NSLog(@"%@",self.pwdString);
    [self.pwdString setString:@""];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //在这里面画线
    //1.获取图形的上下文(画板)
    //2.画点，线，圆
    //3.渲染到视图上
    //如果不是画图片，截图，或者画文字
    //1.确定画的路径
    UIBezierPath * bpath = [UIBezierPath bezierPath];
    //确定线的起始点数组里面第一个按钮
    for (int i =0; i<self.selectedArray.count; i++) {
        UIButton * button = [self.selectedArray objectAtIndex:i];
        //如果是第一个 只需要将path的起始点设到这个按钮的中心
        if (i==0) {
            [bpath moveToPoint:button.center];
        }else{
            //否则就需要画线到按钮的中心点
            [bpath addLineToPoint:button.center];
        }
    }
    //在最后一个按钮和当前触摸点之间画一条线
    [bpath addLineToPoint:_lastPoint];
    //2.画上去
    bpath.lineWidth = 5;
    bpath.lineJoinStyle = kCGLineJoinRound;
    [[UIColor whiteColor]set];
    [bpath stroke];
    
}







@end
