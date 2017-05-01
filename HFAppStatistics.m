//
//  HFAppStatistics.m
//  GoodCoder
//
//  Created by Wang,Hanfeng on 17/4/10.
//  Copyright © 2017年 Wang,Hanfeng. All rights reserved.
//

#import "HFAppStatistics.h"
#import "HFAppStatisticsModel.h"
#import "HFWebViewController.h"
#import "HFNetworkManager.h"
#import "MJExtension.h"
#import "Utilities.h"

static const NSString *gradeCommand = @"gradeCommand";
static const NSString *openUrlCommand = @"openUrlCommand";
static const NSString *clearCommand = @"clearCommand";

@interface HFAppStatistics()
@property (nonatomic, strong)UINavigationController *navigationController;
@end

@implementation HFAppStatistics

+ (instancetype)sharedInstance {
    static HFAppStatistics *appStatistics = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        appStatistics = [[HFAppStatistics alloc] init];
    });
    return appStatistics;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)recordAppUseCountWithURL:(NSString *)urlString navigationController:(UINavigationController *)navigationController{
    self.navigationController = navigationController;
    NSDictionary *appInfoDic = [[NSBundle mainBundle] infoDictionary];
    NSString *appVersion = [appInfoDic objectForKey:@"CFBundleShortVersionString"];
    
    PREP_BLOCK
    [[HFNetworkManager sharedInstance] getRequestWithURL:urlString responseType:ResponseTypeJSON completionBlock:^(BOOL success, id result) {
        BEGIN_BLOCK
        if (success) {
            NSError *error;
            NSDictionary *infoDic = [NSJSONSerialization JSONObjectWithData:[self randomGenerateJSONData] options:NSJSONReadingMutableContainers error:&error];
            if (error) {
                NSLog(@"%@",error);
            } else {
                HFAppStatisticsModel *appStatisticsModel = [HFAppStatisticsModel readLocalAppStatisticsModel];
                if (appStatisticsModel.usedCount == nil) {
                    //初次使用
                    appStatisticsModel.usedCount = @"1";
                    appStatisticsModel.appVersion = appVersion;
                    appStatisticsModel.message = infoDic[@"message"];
                    appStatisticsModel.command = infoDic[@"command"];
                    appStatisticsModel.url = infoDic[@"url"];
                    appStatisticsModel.maxCount = infoDic[@"maxCount"];
                } else {
                    //更新json数据
                    NSInteger usedCount = [appStatisticsModel.usedCount integerValue] + 1;
                    appStatisticsModel.usedCount = [NSString stringWithFormat:@"%ld",(long)usedCount];
                    appStatisticsModel.message = infoDic[@"message"];
                    appStatisticsModel.command = infoDic[@"command"];
                    appStatisticsModel.url = infoDic[@"url"];
                    appStatisticsModel.maxCount = infoDic[@"maxCount"];
                }
                //app安装新版本
                if ([appStatisticsModel.appVersion isEqualToString:appVersion]) {
                } else {
                    appStatisticsModel.usedCount = @"0";
                    appStatisticsModel.neverShowMessageThisVersion = NO;
                    appStatisticsModel.appVersion = appVersion;
                }
                //提示框
                if ([appStatisticsModel.usedCount integerValue] >= [appStatisticsModel.maxCount integerValue] && !appStatisticsModel.neverShowMessageThisVersion) {
                    UIViewController *rootVC = [[UIApplication sharedApplication] keyWindow].rootViewController;
                    [HFAlertController showInViewController:rootVC title:@"提示" message:appStatisticsModel.message okHandlerBlock:^{
                        [self okBtnPressed];
                    } cancelHandlerBlock:^{
                        [self cancelBtnPressed];
                    }];
                }
                [HFAppStatisticsModel writeLocalAppStatisticsModel:appStatisticsModel];
            }
        } else {
            //网络请求失败 读取本地缓存
            HFAppStatisticsModel *appStatisticsModel = [HFAppStatisticsModel readLocalAppStatisticsModel];
            if (appStatisticsModel) {
                NSInteger usedCount = [appStatisticsModel.usedCount integerValue] + 1;
                appStatisticsModel.usedCount = [NSString stringWithFormat:@"%ld",(long)usedCount];
                if ([appStatisticsModel.appVersion isEqualToString:appVersion]) {
                } else {
                    appStatisticsModel.neverShowMessageThisVersion = NO;
                    appStatisticsModel.appVersion = appVersion;
                }
                if ([appStatisticsModel.usedCount integerValue] >= [appStatisticsModel.maxCount integerValue] && !appStatisticsModel.neverShowMessageThisVersion) {
                    UIViewController *rootVC = [[UIApplication sharedApplication] keyWindow].rootViewController;
                    [HFAlertController showInViewController:rootVC title:@"提示" message:appStatisticsModel.message okHandlerBlock:^{
                        [self okBtnPressed];
                    } cancelHandlerBlock:^{
                        [self cancelBtnPressed];
                    }];
                }
                [HFAppStatisticsModel writeLocalAppStatisticsModel:appStatisticsModel];
            }
        }
        END_BLOCK
    }];
}

- (NSData *)randomGenerateJSONData {
    //生成模拟数据
    NSDictionary *jsonDic = @{@"message":@"感谢您的使用，欢迎您对我们产品进行评价",@"command":clearCommand,@"url":@"https://www.baidu.com",@"maxCount":@"2"};
    return [jsonDic mj_JSONData];
}

- (void)handleCommand:(NSString *)command {
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([command isEqualToString:gradeCommand]) {
            [self runGradeCommand];
        } else if ([command isEqualToString:openUrlCommand]) {
            [self runOpenUrlCommand];
        } else if ([command isEqualToString:clearCommand]) {
            [self runClearCommand];
        }
    });
}

- (void)runGradeCommand {
    //跳转到评价页面
    NSString *urlStr = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@&pageNumber=0&sortOrdering=2&mt=8", self.appID];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlStr]];
    NSLog(@"runGradeCommand");
}

- (void)runOpenUrlCommand {
    HFAppStatisticsModel *appStatisticsModel = [HFAppStatisticsModel readLocalAppStatisticsModel];
    HFWebViewController *webVC = [[HFWebViewController alloc] init];
    [self.navigationController pushViewController:webVC animated:YES];
    [webVC openURL:appStatisticsModel.url];
    NSLog(@"runOpenUrlCommand");
}

- (void)runClearCommand {
    [HFAppStatisticsModel clearLocalAppStatisticsModel];
    NSLog(@"runClearCommand");
}

- (void)cancelBtnPressed {
    HFAppStatisticsModel *appStatisticsModel = [HFAppStatisticsModel readLocalAppStatisticsModel];
    appStatisticsModel.neverShowMessageThisVersion = YES;
    [HFAppStatisticsModel writeLocalAppStatisticsModel:appStatisticsModel];
}

- (void)okBtnPressed {
    HFAppStatisticsModel *appStatisticsModel = [HFAppStatisticsModel readLocalAppStatisticsModel];
    [self handleCommand:appStatisticsModel.command];
}

@end
