//
//  MTBtnView.m
//  开心团购
//
//  Created by huiwen on 15/10/18.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "MTBtnView.h"

@implementation MTBtnView

- (id)initWithFrame:(CGRect)frame title:(NSString *)title imageStr:(NSString *)imageStr{
    self = [super initWithFrame:frame];
    if(self){
        //image
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width*0.5-22, 15, 44, 44)];
        imageView.image = [UIImage imageNamed:imageStr];
        [self addSubview:imageView];
        
        //lable
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), frame.size.width, 20)];
        titleLable.text = title;
        titleLable.textAlignment = NSTextAlignmentCenter;
        titleLable.font = [UIFont systemFontOfSize:13];
        [self addSubview:titleLable];
    }
    return self;
}

@end
