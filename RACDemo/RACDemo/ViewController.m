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

typedef BOOL (^JoyceBlock) ();

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) UILabel *label;

@property (copy, nonatomic) JoyceBlock callback;

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
//    [self testLabel];
    
    //!< 测试alert
//    [self testAlert];
    
    //!< 测试通知
//    [self testNotification];
    
//    [self testKVO];
    
    //!< 代码分析
    [self analyse];
    

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



/**
 *  RAC原理分析
 */
- (void)analyse
{
    
//    UITextField *tf = [UITextField new];
//    
//    tf.frame = CGRectMake(100, 100, 100, 100);
//    
//    tf.backgroundColor = [UIColor purpleColor];
//    
//    [self.view addSubview:tf];
//    
//    
//    UILabel *label = [UILabel new];
//    
//    label.frame = CGRectMake(200, 100, 80, 80);
//    
//    [self.view addSubview:label];
//    
//    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
//    
//    label.userInteractionEnabled = YES;
//    
//    [label addGestureRecognizer:tap];
    
    //!< 信号联合
//    RACSignal *signal1 = [tf rac_textSignal];
//    
//    RACSignal *signal2 = [tap rac_gestureSignal];
//    
//    RAC(label,backgroundColor) = [RACSignal combineLatest:@[signal1,signal2] reduce:^id{
//        
//        if (tf.text.length > 5 && tap.state == UIGestureRecognizerStateEnded)
//        {
//            return [UIColor redColor];
//        }else
//        {
//        
//            return [UIColor greenColor];
//        }
//    }];
    
//    //!< 信号关联
//    RAC(label,text) = [tf rac_textSignal];
//
    
    //!< 1 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
      
        
        //!< 3 发送信号
        [subscriber sendNext:@"Joyce RAC"];
        
        //!< 3.1 发送完信号，取消订阅
        [subscriber sendCompleted];
        
        //!< block： 返回RACDisposable 对象，传入的参数是遵循RACSubscriber协议的对象、
        //!< 4 用于取消订阅时倾力资源用，比如释放一些资源
        return [RACDisposable new];
        
        
    }];
    
    
    
    //!< 2.1 订阅Next信号
    [signal subscribeNext:^(id x) {
        
        NSLog(@"next %@",x);
    }];
    
    //!< 2.2 订阅错误信号
    [signal subscribeError:^(NSError *error) {
       
        NSLog(@"error");
        
    }];
    
    //!< 订阅完成信号
    [signal subscribeCompleted:^{
       
        NSLog(@"completed");
        
    }];
    
    

}










































@end
