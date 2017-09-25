//
//  NextVC.m
//  RACDemo
//
//  Created by x on 17/9/25.
//  Copyright © 2017年 cesiumai. All rights reserved.
//

#import "NextVC.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NextVC ()

@end

@implementation NextVC

- (void)viewDidLoad {
    
    [super viewDidLoad];

    //!< 添加按钮，在点击按钮的时候发送通知，测试上一界面的通知效果
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    btn.backgroundColor = [UIColor purpleColor];
    
    [self.view addSubview:btn];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        NSLog(@"按钮点击，通知已发出");
        //!< 发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"JoyceNotification" object:@[@"J",@"O",@"O",@"Y",@"C",@"E"]];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }];
    

}



@end
