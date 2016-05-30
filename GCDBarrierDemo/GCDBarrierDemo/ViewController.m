//
//  ViewController.m
//  GCDBarrierDemo
//
//  Created by IvanDing on 16/5/22.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示GCD中dispatch_barrier_async的使用

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dispatchBarrier];
}

- (void)dispatchBarrier {
    // 自己创建的并行队列
    dispatch_queue_t queue = dispatch_queue_create("com.barrier", DISPATCH_QUEUE_CONCURRENT);
    
    // 在队列中添加任务
    dispatch_async(queue, ^{
        [NSThread sleepForTimeInterval:0.5];
        NSLog(@"block1");
    });
    dispatch_async(queue, ^{
        NSLog(@"block2");
    });
    
    // 使用栅栏函数阻塞任务
    dispatch_barrier_async(queue, ^{
        NSLog(@"barrier block");
    });

    dispatch_async(queue, ^{
        NSLog(@"block3");
    });
    dispatch_async(queue, ^{
        NSLog(@"block4");
    });
}

@end
