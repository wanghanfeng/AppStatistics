//
//  HFWebViewController.h
//  GoodCoder
//
//  Created by Wang,Hanfeng on 17/4/11.
//  Copyright © 2017年 Wang,Hanfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HFWebViewController : UIViewController

/**
 跳转指定URL

 @param urlString 网页视图控制器要打开的url
 */
- (void)openURL:(NSString *)urlString;

@end
