//
//  DiscountViewController.h
//  开心团购
//
//  Created by huiwen on 15/10/18.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscountViewController : UIViewController

/**
 *  webview加载的url
 */
@property(nonatomic, strong) NSString *urlStr;

@property(nonatomic, strong) UIWebView *webView;

@end
