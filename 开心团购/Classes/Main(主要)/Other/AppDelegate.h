//
//  AppDelegate.h
//  开心团购
//
//  Created by huiwen on 15/10/14.
//  Copyright (c) 2015年 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic, assign)double latitude;//经度
@property(nonatomic, assign)double longitude;//纬度



- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

