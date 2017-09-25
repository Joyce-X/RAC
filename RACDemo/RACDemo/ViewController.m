//
//  ViewController.m
//  RACDemo
//
//  Created by x on 17/9/25.
//  Copyright © 2017年 cesiumai. All rights reserved.
//

#import "ViewController.h"

#import "NextVC.h"

#import <ReactiveCocoa/ReactiveCocoa.h>


@interface ViewController ()

@property (weak, nonatomic) UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor orangeColor];
    
    //!< 测试文本框
//    [self textTextfield];
   
    //!< 测试按钮
//    [self testBtn];
    
    //!< 测试label
    [self testLabel];
    
    //!< 测试alert
//    [self testAlert];
    
    //!< 测试通知
//    [self testNotification];
    
    [self testKVO];
    

}

/**
 *  测试文本框
 */
- (void)textTextfield
{
    UITextField *tf = [UITextField new];
    
    tf.borderStyle = UITextBorderStyleBezel;
    
    tf.frame = CGRectMake(100, 140, 150, 30);
    
    [self.view addSubview:tf];
    
    //!< 监听事件
//    [[tf rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x) {
//     
//        NSLog(@"changed");
//      
//    }];
    
    //!< 监听文字变化
    [[tf rac_textSignal] subscribeNext:^(id x) {
        NSLog(@"文字发生变化");
    }];
    
    
}


/**
 *  测试按钮
 */
- (void)testBtn
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    
    btn.backgroundColor = [UIColor redColor];
    
    btn.frame = CGRectMake(100, 100, 100, 100);
    
    [self.view addSubview:btn];
    
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       
        NSLog(@"---------点击按钮执行了---------");
        
    }];
    
    
}

/**
 *  测试label
 */
- (void)testLabel
{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    
    label.backgroundColor = [UIColor purpleColor];
    
    label.userInteractionEnabled = YES;
    
    [self.view addSubview:label];
    
    self.label = label;
    
    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
    
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        
        NSLog(@"点击label");
    }];
    
    //!< 可以同时响应多个时间
//    [[tap rac_gestureSignal] subscribeNext:^(id x) {
//        
//        NSLog(@"点击label2");
//    }];
    
    [label addGestureRecognizer:tap];
    
    
    
}


/**
 测试alert
 */
- (void)testAlert
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"RACSignal" message:@"test msg" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
    
//    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(id x) {
//        
//        NSLog(@"%@",x);
//        
//        
//        
//    }];
    
    
    [[alert rac_buttonClickedSignal] subscribeNext:^(id x) {
        
         NSLog(@"%@",x);
    }];
    
    [alert show];
    
    
}


/**
 测试通知
 */
- (void)testNotification
{
    
      [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"JoyceNotification" object:nil] subscribeNext:^(id x) {
         
          NSLog(@"接收到通知");
          
          NSLog(@"%@",x);
          
          self.view.backgroundColor = [UIColor yellowColor];
          
          
      }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        
        [self presentViewController:[NextVC new] animated:YES completion:nil];
        
    });
    
    
}




/**
 测试KVO
 */
- (void)testKVO
{
    
    //!< 开启定时器，改变label.alpha
    [NSTimer scheduledTimerWithTimeInterval:.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        self.label.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1];
        
        self.label.transform = CGAffineTransformMakeRotation(arc4random_uniform(301)/100.0);
        
        self.label.alpha  = arc4random_uniform(256)/255.0;
        
    }];
    
    [RACObserve(self.label, alpha) subscribeNext:^(id x) {
       
        NSLog(@"监听到透明度在发生变化");
        
    }];
    
    
}













































@end
