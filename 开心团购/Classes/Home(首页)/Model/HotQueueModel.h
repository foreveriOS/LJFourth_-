//
//  HotQueueModel.h
//  开心团购
//
//  Created by huiwen on 15/10/17.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotQueueModel : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *imageUrl ;
@property(nonatomic, strong) NSNumber *within;
@property(nonatomic, strong) NSString *comment;
@property(nonatomic, strong) NSString *serviceUrl;
@end
