//
//  UserOtherCell.m
//  small_douApp
//
//  Created by zhongli on 15/6/18.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "UserOtherCell.h"

@implementation UserOtherCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createContentView];
    }
    return self;
    
}

-(void)createContentView
{
    
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
