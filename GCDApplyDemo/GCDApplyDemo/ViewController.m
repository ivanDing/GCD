//
//  ViewController.m
//  GCDApplyDemo
//
//  Created by IvanDing on 16/5/30.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示GCD中dispatch_apply的使用

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //串行队列的dispatch_apply
    dispatch_queue_t serialQueue = dispatch_queue_create("com.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_apply(10, serialQueue, ^(size_t index) {
        NSLog(@"apply -- %zu", index);
    });
    
    //并行队列的dispatch_apply
    dispatch_queue_t currentQueue = dispatch_queue_create("com.comcurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_apply(10, currentQueue, ^(size_t index) {
        NSLog(@"apply -- %zu", index);
    });
}

/**
 *  apply造成死锁
 */
- (void)deadlock {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.serial", DISPATCH_QUEUE_SERIAL);
    dispatch_apply(10, serialQueue, ^(size_t index) {
        NSLog(@"apply -- %zu", index);
        dispatch_apply(10, serialQueue, ^(size_t index) {
            NSLog(@"apply -- %zu", index);
        });
    });
}

@end
