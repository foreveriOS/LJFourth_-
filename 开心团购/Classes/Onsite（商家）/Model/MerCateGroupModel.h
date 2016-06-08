//
//  MerCateGroupModel.h
//  开心团购
//
//  Created by huiwen on 15/10/19.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MerCateGroupModel : NSObject

@property(nonatomic, strong) NSNumber *id;
@property(nonatomic, strong) NSNumber *index;
@property(nonatomic, strong) NSNumber *parentID;
@property(nonatomic, strong) NSNumber *count;
@property(nonatomic, strong) NSString *name;


@property(nonatomic, strong) NSMutableArray *list;


@end
