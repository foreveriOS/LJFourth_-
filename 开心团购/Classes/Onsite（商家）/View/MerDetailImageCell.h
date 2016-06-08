//
//  MerDetailImageCell.h
//  开心团购
//
//  Created by huiwen on 15/10/20.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerDetailImageCell : UITableViewCell

@property(nonatomic, strong) NSString *BigImgUrl;
@property(nonatomic, strong) NSString *SmallImgUrl;
@property(nonatomic, strong) NSNumber *score;
@property(nonatomic, strong) NSNumber *avgPrice;
@property(nonatomic, strong) NSString *shopName;

@end
