//
//  MTNetworkSingletion.m
//  开心团购
//
//  Created by huiwen on 15/10/17.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import "MTNetworkSingletion.h"

@implementation MTNetworkSingletion

+ (MTNetworkSingletion *)shareManager
{
    static MTNetworkSingletion *sharedNetworkungSingletion = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNetworkungSingletion = [[self alloc] init];
    });
    return sharedNetworkungSingletion;
    
}

- (AFHTTPRequestOperationManager *)baseHttpRequest
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager  manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json", nil];
    return manager;

}

#pragma mark - 获取广告图片
- (void)getAdvLoadingImage:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    //url中含有中文，需要编码
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSString *errorStr = [error.userInfo objectForKey:@"NSLocalizedDescription"];
        if(failure){
            failure(error);
        }
    }];
}

#pragma mark - 抢购
- (void)getRushBuyResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success){
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(failure){
         failure(error);
        }
        
    }];

}

#pragma mark- 热门排队
- (void)getHotQueueResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
        success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure){
            failure(error);
        }
    }];

}

#pragma mark- 推荐
- (void)getRecommendResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure){
            success(failure);
        }
    }];

}

#pragma mark - 折扣
- (void)getDiscountResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure){
            failure(error);
        }
    }];
}

#pragma mark - 折扣详情
-(void)getOCDiscountResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure){
            failure(error);
        }
    }];
}

#pragma mark - 店铺详情
-(void)getShopResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure){
            failure(error);
        }
    }];
}

#pragma mark - 店铺看了还看了
-(void)getShopRecommendResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    [manager.requestSerializer setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"gzip, deflate, sdch" forHTTPHeaderField:@"Accept-Encoding"];
    [manager.requestSerializer setValue:@"zh-CN,zh;q=0.8,en;q=0.6" forHTTPHeaderField:@"Accept-Language"];
    [manager.requestSerializer setValue:@"max-age=0" forHTTPHeaderField:@"Cache-Control"];
    [manager.requestSerializer setValue:@"api.meituan.com" forHTTPHeaderField:@"Host"];
    [manager.requestSerializer setValue:@"keep-alive" forHTTPHeaderField:@"Proxy-Connection "];
    [manager.requestSerializer setValue:@"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_0) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/43.0.2357.124 Safari/537.36" forHTTPHeaderField:@"User-Agent"];
    
    
    //两种编码方式
    //    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failure(error);
    }];
}

#pragma mark - 上门


#pragma mark - 上门服务
-(void)getHomeServiceResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure){failure(error);}
    }];
}

#pragma mark - 上门服务广告
-(void)getServiceAdvResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure){
            failure(error);
        }
    }];
}

#pragma mark - 商家

#pragma mark - 获取商家列表
-(void)getMerchantListResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    
    //两种编码方式
    //    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success(responseObject);
        };
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure){
            failure(error);
        }
    }];
}

#pragma mark - 获取当前位置信息
-(void)getPresentLocationResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    
    //两种编码方式
    //    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success(responseObject);
        };
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure){
            failure(error);
        }
    }];
}

#pragma mark - 获取cate分组信息
-(void)getCateListResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    
    //两种编码方式
    //    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success(responseObject);
        };
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure){
            failure(error);
        }
    }];
}

#pragma mark - 获取商家详情
-(void)getMerchantDetailResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    
    //两种编码方式
    //    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success(responseObject);
        };
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure){
            failure(error);
        }
    }];
}

#pragma mark - 获取商家附近团购
-(void)getAroundGroupPurchaseResult:(NSDictionary *)userInfo url:(NSString *)url success:(void(^)(id responseBody))success failure:(void(^)(NSError *error))failure{
    AFHTTPRequestOperationManager *manager = [self baseHttpRequest];
    
    //两种编码方式
    //    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlStr = [url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        if(success){
            success(responseObject);
        };
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if(failure){
            failure(error);
        }
    }];
}




@end
