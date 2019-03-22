//
//  UIView+FrameExtension.m
//  图片毛玻璃效果
//
//  Created by 李斯然 on 2019/3/8.
//  Copyright © 2019年 siranlee. All rights reserved.
//

#import "UIView+FrameExtension.h"

@implementation UIView (FrameExtension)
- (void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
-(CGFloat)x{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.frame.origin.x,y, self.frame.size.width, self.frame.size.height);
}
- (CGFloat)y{
    return self.frame.origin.y;
}
-(void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
}
-(CGFloat)width{
    return self.frame.size.width;
}
-(void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);
}
-(CGFloat)height{
    return self.frame.size.height;
}
@end
