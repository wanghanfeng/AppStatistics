//
//  BDNetworkManager.h
//  GoodCoder
//
//  Created by Wang,Hanfeng on 17/4/11.
//  Copyright © 2017年 Wang,Hanfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BDNetworkManager : NSObject


/**
 服务端的响应类型

 - ResponseTypeJSON: JSON格式
 - ResponseTypeXML: XML格式
 - ResponseTypeDATA: DATA格式
 */
typedef NS_ENUM(NSUInteger, responseType) {
    ResponseTypeJSON,
    ResponseTypeXML,
    ResponseTypeDATA,
};

/**
 类方法 获取网络管理器的单例对象，在需要进行网络操作时调起获得单例对象

 @return 网络管理器的单例对象
 */
+ (instancetype)sharedInstance;


/**
 GET方法，由单例对象在GET请求时调起

 @param urlString 服务端url
 @param responseType 响应类型
 @param block 回调block
 @return URLSessionDataTask对象
 */
- (NSURLSessionDataTask *)getRequestWithURL:(NSString *)urlString responseType:(responseType)responseType completionBlock:(void (^)(BOOL success, id result))block;

@end
