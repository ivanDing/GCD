//
//  ViewController.m
//  GCDAfterDemo
//
//  Created by IvanDing on 16/5/30.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示GCD中dispatch_after的使用

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch screen");
    
    //NSObject延迟方法
    [self performSelector:@selector(run) withObject:self afterDelay:1];
    
    //延迟2秒后打印
    [self delayTime:2 block:^{
        NSLog(@"disatch after 3s");
    }];
    
}

/**
 *  封装GCD延迟执行函数
 *
 *  @param sceonds 延迟时间(多少秒)
 *  @param block   延迟执行的block
 */
- (void)delayTime:(int64_t)sceonds block:(dispatch_block_t)block {
    //GCD延迟执行函数
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(sceonds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

/**
 *  run方法
 */
-(void)run {
    NSLog(@"run");
}

@end
