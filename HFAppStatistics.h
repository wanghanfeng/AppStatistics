//
//  BDAppStatistics.h
//  GoodCoder
//
//  Created by Wang,Hanfeng on 17/4/10.
//  Copyright © 2017年 Wang,Hanfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BDAlertController.h"

@interface BDAppStatistics : NSObject

/**
 应用在App Store的appID
 */
@property (nonatomic, copy)NSString *appID;

/**
 类方法 获取应用启动统计的单例对象

 @return 应用启动统计的单例对象
 */
+ (instancetype)sharedInstance;

/**
 统计应用启动次数 由应用启动统计的单例对象负责在应用启动时调起
 
 @param urlString 服务端url
 @param navigationController 与用户进行交互所在的导航控制器
 */
- (void)recordAppUseCountWithURL:(NSString *)urlString navigationController:(UINavigationController *)navigationController;
@end
