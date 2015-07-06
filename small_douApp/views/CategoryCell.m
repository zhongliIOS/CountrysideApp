//
//  CategoryCell.m
//  small_douApp
//
//  Created by zhongli on 15/7/3.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell
{


}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createContenView];
    }
    return self;

}

-(void)createContenView
{
    UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 55)];
    mainView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:mainView];

    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
