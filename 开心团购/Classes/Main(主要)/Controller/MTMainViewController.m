//
//  MTMainViewController.m
//  开心团购
//
//  Created by huiwen on 15/10/17.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "MTMainViewController.h"
#import "MTBaseNavigatinController.h"
#import "HomeViewController.h"
#import "JZOnSiteViewController.h"
#import "JZMerchantViewController.h"
#import "MineViewController.h"
#import "MoreViewController.h"

@interface MTMainViewController ()

@end

@implementation MTMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildVcs];
}
- (void)setUpChildVcs
{
    //1.
    HomeViewController *VC1 = [[HomeViewController alloc] init];
     MTBaseNavigatinController *nav1 = [[MTBaseNavigatinController alloc] initWithRootViewController:VC1];
    
    //    InfoViewController *VC2 = [[InfoViewController alloc] init];
    JZOnSiteViewController *VC2 = [[JZOnSiteViewController alloc] init];
    MTBaseNavigatinController *nav2 = [[MTBaseNavigatinController alloc] initWithRootViewController:VC2];
    JZMerchantViewController *VC3 = [[JZMerchantViewController alloc] init];
    MTBaseNavigatinController *nav3 = [[MTBaseNavigatinController alloc] initWithRootViewController:VC3];
    MineViewController *VC4 = [[MineViewController alloc] init];
    MTBaseNavigatinController *nav4 = [[MTBaseNavigatinController alloc] initWithRootViewController:VC4];
    MoreViewController *VC5 = [[MoreViewController alloc] init];
    MTBaseNavigatinController *nav5 = [[MTBaseNavigatinController alloc] initWithRootViewController:VC5];

    VC1.title = @"团购";
    VC2.title = @"上门";
    VC3.title = @"商家";
    VC4.title = @"我的";
    VC5.title = @"更多";
    //2.
    NSArray *viewCtrs = @[nav1,nav2,nav3,nav4,nav5];
    
    //3.
    [self setViewControllers:viewCtrs animated:YES];
    
    //4.
    UITabBar *tabbar = self.tabBar;
    UITabBarItem *item1 = [tabbar.items objectAtIndex:0];
    UITabBarItem *item2 = [tabbar.items objectAtIndex:1];
    UITabBarItem *item3 = [tabbar.items objectAtIndex:2];
    UITabBarItem *item4 = [tabbar.items objectAtIndex:3];
    UITabBarItem *item5 = [tabbar.items objectAtIndex:4];
    
    item1.selectedImage = [[UIImage imageNamed:@"icon_tabbar_homepage_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item1.image = [[UIImage imageNamed:@"icon_tabbar_homepage"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.selectedImage = [[UIImage imageNamed:@"icon_tabbar_onsite_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item2.image = [[UIImage imageNamed:@"icon_tabbar_onsite"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    item2.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item3.selectedImage = [[UIImage imageNamed:@"icon_tabbar_merchant_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item3.image = [[UIImage imageNamed:@"icon_tabbar_merchant_normal"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    item3.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item4.selectedImage = [[UIImage imageNamed:@"icon_tabbar_mine_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item4.image = [[UIImage imageNamed:@"icon_tabbar_mine"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    item4.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    item5.selectedImage = [[UIImage imageNamed:@"icon_tabbar_misc_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    item5.image = [[UIImage imageNamed:@"icon_tabbar_misc"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //    item5.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);

}

+ (void)initialize
{
    //改变UITabBarItem字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:RGB(54, 185,175),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
}


@end













