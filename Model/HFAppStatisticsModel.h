//
//  BDAppStatisticsModel.h
//  GoodCoder
//
//  Created by Wang,Hanfeng on 17/4/10.
//  Copyright © 2017年 Wang,Hanfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString* const BDAppStatisticsIdentifier = @"BDAppStatisticsIdentifier";

@interface BDAppStatisticsModel : NSObject

/**
 描述应用当前已启动次数
 */
@property (nonatomic, copy)NSString *usedCount;

/**
 描述最大应用最大不显示对话框启动次数
 */
@property (nonatomic, copy)NSString *maxCount;

/**
 描述服务端传回的需要展示的Message值
 */
@property (nonatomic, copy)NSString *message;

/**
 描述应用版本号
 */
@property (nonatomic, copy)NSString *appVersion;

/**
 描述服务端的命令类别
 */
@property (nonatomic, copy)NSString *command;

/**
 描述服务端指定访问页面的url
 */
@property (nonatomic, copy)NSString *url;

/**
 描述当前版本是否展示交互对话框
 */
@property (nonatomic, assign)BOOL neverShowMessageThisVersion;


/**
 单例类方法，获取应用启动统计的数据模型单例对象，该单例对象定义BDAppStatistics对象所需使用的数据对象

 @return 应用启动统计的数据模型单例对象
 */
+ (BDAppStatisticsModel *)readLocalAppStatisticsModel;

/**
 类方法，当需要将数据模型对象数据持久化时调起，将数据模型对象写入文件

 @param appStatisticsModel 数据模型对象
 */
+ (void)writeLocalAppStatisticsModel:(BDAppStatisticsModel *)appStatisticsModel;

/**
 类方法，清楚当前已经数据持久化的对象模型
 */
+ (void)clearLocalAppStatisticsModel;

/**
 将数据模型对象转换成NSDictionary对象

 @return 数据模型对应的NSDictionary对象
 */
- (NSDictionary *)convertDictionary;

@end
