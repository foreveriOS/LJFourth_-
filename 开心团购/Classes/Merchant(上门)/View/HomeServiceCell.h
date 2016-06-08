//
//  HomeServiceCell.h
//  开心团购
//
//  Created by huiwen on 15/10/19.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeServiceDelegate <NSObject>
@optional
-(void)didSelectAtIndex:(NSInteger)index;

@end

@interface HomeServiceCell : UITableViewCell

@property(nonatomic, strong) NSMutableArray *homeServiceArray;
@property(nonatomic, assign) id<HomeServiceDelegate> delegate;

@end
