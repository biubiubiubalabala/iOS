//
//  UIView+FrameExtension.h
//  图片毛玻璃效果
//
//  Created by 李斯然 on 2019/3/8.
//  Copyright © 2019年 siranlee. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FrameExtension)
//类别中不会为我们添加成员变量，只能添加方法
/** x坐标*/
@property (nonatomic,assign)CGFloat  x;
/** y坐标*/
@property (nonatomic,assign)CGFloat  y;
/** 宽度*/
@property (nonatomic,assign)CGFloat  width;
/** 高度*/
@property (nonatomic,assign)CGFloat  height;
@end

NS_ASSUME_NONNULL_END
