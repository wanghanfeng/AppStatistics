//
//  NSDictionary+BDTranformToString.h
//  GoodCoder
//
//  Created by Wang,Hanfeng on 17/4/11.
//  Copyright © 2017年 Wang,Hanfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (BDTranformToString)


/**
 负责将传入的NSDictionary对象转换成NSString对象

 @return 与NSDictionary对象对应的NSString对象
 */
- (NSString *)bd_tranformToNSString;

@end
