//
//  MerchantFilterView.h
//  开心团购
//
//  Created by huiwen on 15/10/19.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol MerchantFilterViewDelegate <NSObject>
@optional
/**
 *  点击tableview，过滤id
 */
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath withId:(NSNumber *)ID withName:(NSString *)name;

@end


@interface MerchantFilterView : UIView

@property(nonatomic, strong) UITableView *tableViewOfGroup;
@property(nonatomic, strong) UITableView *tableViewOfDetail;

@property(nonatomic, assign) id<MerchantFilterViewDelegate> delegate;


@end
