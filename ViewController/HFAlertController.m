//
//  HFAlertController.m
//  GoodCoder
//
//  Created by Wang,Hanfeng on 17/4/11.
//  Copyright © 2017年 Wang,Hanfeng. All rights reserved.
//

#import "HFAlertController.h"
#import "HFAppStatisticsModel.h"

@interface HFAlertController ()

@end

@implementation HFAlertController

+ (void)showInViewController:(UIViewController *)viewController title:(NSString *)title message:(NSString *)message okHandlerBlock:(void (^)(void))okHandlerBlock cancelHandlerBlock:(void (^)(void))cancelHandlerBlock {
    HFAlertController *alertC = [HFAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (cancelHandlerBlock) {
           cancelHandlerBlock();
        }
    }];
    [alertC addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (okHandlerBlock) {
           okHandlerBlock();
        }
    }];
    [alertC addAction:OKAction];
    [viewController presentViewController:alertC animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}




@end
