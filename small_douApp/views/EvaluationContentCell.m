//
//  EvaluationContentCell.m
//  small_douApp
//
//  Created by zhongli on 15/6/24.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import "EvaluationContentCell.h"

@implementation EvaluationContentCell
{
    UIImageView *_imageV;
    UILabel *_nickNameLabel;
    UILabel *_dateLabel;
    UILabel *_evaStatusLabel;
    UILabel *_contentLabel;
    UIView *_bottomLine;
    UIView *_responseLine;
    UILabel *_responseLabel;
    UIView *_bgView;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createContentView];
    }
    return self;
}

-(void)createContentView
{
    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 140)];
    _bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_bgView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.5)];
    line.backgroundColor = color_line1;
    [_bgView addSubview:line];
    
    _bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 0.5)];
    _bottomLine.backgroundColor = color_line1;
    [_bgView addSubview:_bottomLine];
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(leftSpace, 12, 35, 35)];
    _imageV.layer.cornerRadius = 17.5;
    _imageV.layer.masksToBounds = YES;
    _imageV.contentMode = UIViewContentModeScaleAspectFill;
    _imageV.backgroundColor = [UIColor greenColor];
    [_bgView addSubview:_imageV];
    
    _nickNameLabel = [[UILabel alloc]init];
    _nickNameLabel.frame = CGRectMake(CGRectGetMaxX(_imageV.frame)+10, 16, 100, 28);
    _nickNameLabel.text = @"国产零零七";
    _nickNameLabel.font = [UIFont systemFontOfSize:size_font2];
    _nickNameLabel.textColor = color_font_gray1;
    [_bgView addSubview:_nickNameLabel];
    
    _dateLabel = [[UILabel alloc]init];
    _dateLabel.frame = CGRectMake(ScreenW-110, 16, 100, 28);
    _dateLabel.text = @"2015-06-11";
    _dateLabel.textAlignment = NSTextAlignmentRight;
    _dateLabel.font = [UIFont systemFontOfSize:size_font3];
    _dateLabel.textColor = color_font_gray1;
    [_bgView addSubview:_dateLabel];
    
    UIView *midLine = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_imageV.frame)+8, 44, ScreenW-65, 0.5)];
    midLine.backgroundColor = color_line2;
    [_bgView addSubview:midLine];
    
    NSString *str = @"刚刚送来的，看着到五点就忘记开电脑参考价为进口非常健康为房价参考文件看附件文件费金额为分局网健康V刹健康为科技饥饿法即可我就未缴费金额为甲方将文件费";
    CGSize size = [LUnity CalSizeByString:str ForWidth:ScreenW-20 ForFont:[UIFont systemFontOfSize:size_font3]];
    _contentLabel = [[UILabel alloc]init];
    _contentLabel.frame = CGRectMake(leftSpace, CGRectGetMaxY(midLine.frame)+10, size.width, size.height);
    _contentLabel.text = str;
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:size_font3];
    _contentLabel.textColor = color_font_gray1;
    [_bgView addSubview:_contentLabel];
    
    _responseLine = [[UIView alloc]init];
    _responseLine.backgroundColor = color_line2;
    [_bgView addSubview:_responseLine];
    
    _responseLabel = [[UILabel alloc]init];
    _responseLabel.numberOfLines = 0;
    _responseLabel.font = [UIFont systemFontOfSize:size_font3];
    _responseLabel.textColor = color_font_black;
    [_bgView addSubview:_responseLabel];
}

-(void)fillDataWithModel:(ObjReview *)obj
{
    if (!obj) {
        return;
    }
    NSString *content = obj.content;
    CGSize size = [LUnity CalSizeByString:content ForWidth:ScreenW-20 ForFont:[UIFont systemFontOfSize:size_font3]];
    _contentLabel.frame = CGRectMake(_contentLabel.frame.origin.x, _contentLabel.frame.origin.y, size.width, size.height);
    _contentLabel.text = content;
    
    _bgView.frame = CGRectMake(0, 0, ScreenW, CGRectGetMaxY(_contentLabel.frame)+10);
    _bottomLine.frame = CGRectMake(0, CGRectGetMaxY(_contentLabel.frame)+10-0.5, ScreenW, 0.5);
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
