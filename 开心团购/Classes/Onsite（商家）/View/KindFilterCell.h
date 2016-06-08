//
//  KindFilterCell.h
//  开心团购
//
//  Created by huiwen on 15/10/19.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  MerCateGroupModel;
@interface KindFilterCell : UITableViewCell
@property(nonatomic, strong) MerCateGroupModel *groupM;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withFrame:(CGRect)frame;

@end
