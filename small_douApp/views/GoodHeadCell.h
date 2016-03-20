//
//  GoodHeadCell.h
//  small_douApp
//
//  Created by zhongli on 15/6/19.
//  Copyright (c) 2015年 zhongli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodHeadCell : UITableViewCell<UIWebViewDelegate>

@property(nonatomic,strong)UIScrollView *mainScrollView;
@property(nonatomic,strong)UILabel *pageLabel;
@property(nonatomic,strong)UIButton *addressBtn;
@property(nonatomic,copy)void(^CallBackEvaluation)(void );
@property(nonatomic,copy)void(^CallBackCount)(NSInteger );
@property(nonatomic,copy)void(^Callheight)(CGFloat );

@property(nonatomic,strong)UIWebView *webView;

-(void)fillDataWithModel:(ObjProductDetail *)model;
-(void)fillUrl:(NSString *)url;


@end
