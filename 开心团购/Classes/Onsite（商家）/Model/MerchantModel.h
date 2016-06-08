//
//  MerchantModel.h
//  开心团购
//
//  Created by huiwen on 15/10/19.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerchantModel : NSObject

@property (nonatomic, strong) NSString *frontImg;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *avgScore;//星星
@property (nonatomic, strong) NSNumber *markNumbers;//评价个数
@property (nonatomic, strong) NSString *cateName;

@property (nonatomic, strong) NSString *areaName;
@property (nonatomic, strong) NSNumber *avgPrice;
@property (nonatomic, strong) NSNumber *brandId;
@property (nonatomic, strong) NSString *poiid;

@end
