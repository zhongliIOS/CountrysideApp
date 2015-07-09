//
//  StarView.m
//  small_douApp
//
//  Created by zhongli on 15/7/9.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "StarView.h"

@implementation StarView



-(void)setStarNum:(CGFloat)starNum
{
    [self createStarViewWith:starNum];

}
-(void)createStarViewWith:(CGFloat)num
{
    CGFloat imageWidth = 21.5;
    CGFloat space = 0;
    int tempNum = (int)num;
    for (int i=0; i<tempNum; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((imageWidth+space)*i, 0, imageWidth, imageWidth)];
        imageView.image = [UIImage imageNamed:@"yixing"];
        [self addSubview:imageView];
    }
    if (tempNum!=num) {
        CGFloat selfWidth = (imageWidth+space)*(tempNum+1);
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((imageWidth+space)*tempNum, 0, imageWidth, imageWidth)];
        imageView.image = [UIImage imageNamed:@"banxing"];
        [self addSubview:imageView];
        self.frame = CGRectMake(ScreenW-10-selfWidth, self.frame.origin.y, selfWidth, 21.5);
    }
    else
    {
        CGFloat selfWidth = (imageWidth+space)*tempNum;
        self.frame = CGRectMake(ScreenW-10-selfWidth, self.frame.origin.y, selfWidth, 21.5);
    }


}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
