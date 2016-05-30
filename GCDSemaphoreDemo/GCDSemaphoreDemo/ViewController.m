//
//  ViewController.m
//  GCDSemaphoreDemo
//
//  Created by IvanDing on 16/5/28.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示GCD中dispatch_semaphore的使用

#import "ViewController.h"

#define kGetGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define KGetMainQueue dispatch_get_main_queue()

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self semaphoreDemo];
}

/**
 *  信号量demo
 */
- (void)semaphoreDemo {
    int step = 3;
    int mainData = 0;
    //创建信号量
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create("com.queue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        int sum = 0;
        for (int i = 0; i < 5; i++) {
            sum += step;
            NSLog(@" >> Sum: %d", sum);
        }
        //发送信号
        dispatch_semaphore_signal(sem);
    });
    //等待信号
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    for (int i = 0; i < 5; i++) {
        mainData++;
        NSLog(@">> Main Data: %d",mainData);
    }
}

@end
