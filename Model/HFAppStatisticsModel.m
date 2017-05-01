//
//  HFAppStatisticsModel.m
//  GoodCoder
//
//  Created by Wang,Hanfeng on 17/4/10.
//  Copyright © 2017年 Wang,Hanfeng. All rights reserved.
//

#import "HFAppStatisticsModel.h"
#import "MJExtension.h"
#import "NSDictionary+HFTranformToString.h"

@implementation HFAppStatisticsModel

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSDictionary *)convertDictionary {
    NSDictionary *dictionary = @{@"usedCount":self.usedCount,@"maxCount":self.maxCount,@"message":self.message,@"appVersion":self.appVersion,@"command":self.command,@"url":self.url,@"neverShowMessageThisVersion":[NSNumber numberWithBool:self.neverShowMessageThisVersion]};
    return dictionary;
}

+ (HFAppStatisticsModel *)readLocalAppStatisticsModel {
    NSString *infoPath = [NSString stringWithFormat:@"%lu",(unsigned long)[HFAppStatisticsIdentifier hash]];
    infoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:infoPath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:infoPath]) {
        HFAppStatisticsModel *appStatisticsModel = [HFAppStatisticsModel mj_objectWithFile:infoPath];
        return appStatisticsModel;
    } else {
        return [[HFAppStatisticsModel alloc] init];
    }
}

+ (void)writeLocalAppStatisticsModel:(HFAppStatisticsModel *)appStatisticsModel {
    NSString *infoPath = [NSString stringWithFormat:@"%lu",(unsigned long)[HFAppStatisticsIdentifier hash]];
    infoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:infoPath];
    [[appStatisticsModel convertDictionary] writeToFile:infoPath atomically:YES];
    NSLog(@"%@",[[appStatisticsModel convertDictionary] HF_tranformToNSString]);
}

+ (void)clearLocalAppStatisticsModel {
     NSString *infoPath = [NSString stringWithFormat:@"%lu",(unsigned long)[HFAppStatisticsIdentifier hash]];
    [[NSFileManager defaultManager] removeItemAtPath:infoPath error:nil];
}

@end
