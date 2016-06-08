//
//  RushCell.m
//  meituan
//
//  Created by jinzelu on 15/7/1.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "RushCell.h"
#import "UIImageView+WebCache.h"


@implementation RushCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        for(int i =0;i < 3;i++){
            //背景view
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBackView:)];
            UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(i*screen_width/3.0, 40, (screen_width - 3)/3, 80)];
            backView.tag = 100+i;
            [backView addGestureRecognizer:tap];
            [self.contentView addSubview:backView];
            
            //店家图片
            UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (screen_width - 3)/3, 50)];
            imageV.contentMode = UIViewContentModeScaleAspectFit;
            imageV.tag = i+20;
            [backView addSubview:imageV];
            
            //风格线
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(i*screen_width/3 - 1, 45, 0.5, 65)];
            //新价格
            UILabel *newPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, backView.frame.size.width/2, 30)];
            newPrice.tag = 50+i;
            newPrice.textColor = RGB(245, 185, 98);
            newPrice.textAlignment = NSTextAlignmentRight;
            [backView addSubview:newPrice];
            //旧价格
            UILabel *oldPiceLable = [[UILabel alloc] initWithFrame:CGRectMake(backView.frame.size.width/2+5,50,backView.frame.size.width/2 - 5,30)];
            oldPiceLable.tag = 70+i;
            oldPiceLable.textColor = navigationBarColor;
            oldPiceLable.font = [UIFont systemFontOfSize:13];
            [backView addSubview:oldPiceLable];
            

            //名店抢购图
            UIImageView *mingdian = [[UIImageView alloc] initWithFrame:CGRectMake(20, 7, 78, 25)];
            [mingdian setImage:[UIImage imageNamed:@"todaySpecialHeaderTitleImage"]];
            [self addSubview:mingdian];
         
            
        }
    }
    return self;
}

- (void)setRushData:(NSMutableArray *)rushData{
    for(int i = 0;i < 3;i++){
        //取模型
        RushDealsModel *rush = rushData[i];
        NSString *imageUrl = rush.mdcLogoUrl;
        NSInteger newPrice = [rush.campaignprice integerValue];
        NSInteger oldPrice = [rush.price integerValue];
        //设置图片
        UIImageView *imageV = (UIImageView *)[self viewWithTag:20+i];
        [imageV sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
        //新价格
        UILabel *newPriceLabel = (UILabel *)[self viewWithTag:50+i];
        newPriceLabel.text = [NSString stringWithFormat:@"%ld元",newPrice];
        //旧价格
        UILabel *oldPriceLabel = (UILabel *)[self viewWithTag:70+i];
        NSString *oldStr = [NSString stringWithFormat:@"%ld元",oldPrice];
        
        //显示中划线
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc] initWithString:oldStr attributes:attribtDic];
        oldPriceLabel.attributedText = attribtStr;
        
    }
}

-(void)OnTapBackView:(UITapGestureRecognizer *)sender{
    NSLog(@"tag:%ld",sender.view.tag);
    [self.delegate didSelectRushIndex:sender.view.tag];
}
@end
