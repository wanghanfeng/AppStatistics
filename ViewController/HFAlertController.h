//
//  BDAlertController.h
//  GoodCoder
//
//  Created by Wang,Hanfeng on 17/4/11.
//  Copyright © 2017年 Wang,Hanfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Utilities.h"

@interface BDAlertController : UIAlertController

//提示框接口

/**
 展示提示框

 @param viewController 提示框应该出现的视图控制器
 @param title 提示款的标题
 @param message 提示框展示的消息
 @param okHandlerBlock 确定点击事件的响应block
 @param cancelHandlerBlock 取消点击事件的响应block
 */
+ (void)showInViewController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message okHandlerBlock:(void (^)(void))okHandlerBlock cancelHandlerBlock:(void (^)(void))cancelHandlerBlock;

@end
