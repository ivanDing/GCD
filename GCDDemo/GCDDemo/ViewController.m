//
//  ViewController.m
//  GCDDemo
//
//  Created by IvanDing on 16/5/20.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示GCD的创建以及基本使用

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 异步函数 + 串行队列
//    [self asyncSerialQueue];
    
    // 异步函数 + 主线程串行队列
//    [self asyncMainSerialQueue];
    
    // 异步函数 + 异步队列
//    [self asyncConcurrentQueue];
    
    // 异步函数 + 全局异步队列
//    [self asyncGlobalConcurrentQueue];
    
    // 同步函数 + 串行队列
//    [self syncSerialQueue];
    
    // 同步函数 + 主线程串行队列
//    [self syncMainSerialQueue];
    
    // 同步函数 + 异步队列
//    [self syncConcurrentQueue];
    
    // 同步函数 + 全局异步队列
    [self syncGlobalConcurrentQueue];
}

/**
 *  异步函数 + 串行队列
 */
- (void)asyncSerialQueue {
    NSLog(@"%s", __func__);
    // 自己创建的串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.ivanding.serial", DISPATCH_QUEUE_SERIAL);
    // 异步函数执行任务
    dispatch_async(queue, ^{
        NSLog(@"asyncSerial1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncSerial2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncSerial3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncSerial4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncSerial5---%@", [NSThread currentThread]);
    });
}

/**
 *  异步函数 + 主线程串行队列
 */
- (void)asyncMainSerialQueue {
    NSLog(@"%s", __func__);
    // 获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    // 异步函数执行任务
    dispatch_async(queue, ^{
        NSLog(@"asyncMainSerial1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncMainSerial2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncMainSerial3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncMainSerial4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncMainSerial5---%@", [NSThread currentThread]);
    });
}

/**
 *  异步函数 + 异步队列
 */
- (void)asyncConcurrentQueue {
    NSLog(@"%s", __func__);
    // 自己创建的异步队列
    dispatch_queue_t queue = dispatch_queue_create("com.ivanding.concurrent", DISPATCH_QUEUE_CONCURRENT);
    // 异步函数执行任务
    dispatch_async(queue, ^{
        NSLog(@"asyncConcurrent1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncConcurrent2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncConcurrent3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncConcurrent4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncConcurrent5---%@", [NSThread currentThread]);
    });
}

/**
 *  异步函数 + 全局异步队列
 */
- (void)asyncGlobalConcurrentQueue {
    NSLog(@"%s", __func__);
    // 获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 异步函数执行任务
    dispatch_async(queue, ^{
        NSLog(@"asyncGlobalConcurrent1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncGlobalConcurrent2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncGlobalConcurrent3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncGlobalConcurrent4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"asyncGlobalConcurrent5---%@", [NSThread currentThread]);
    });
}

/**
 *  同步函数 + 串行队列
 */
- (void)syncSerialQueue {
    NSLog(@"%s", __func__);
    // 自己创建的串行队列
    dispatch_queue_t queue = dispatch_queue_create("com.ivanding.serial", DISPATCH_QUEUE_SERIAL);
    // 同步函数执行任务
    dispatch_sync(queue, ^{
        NSLog(@"syncSerial1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncSerial2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncSerial3---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncSerial4---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncSerial5---%@", [NSThread currentThread]);
    });
}

/**
 *  同步函数 + 主线程串行队列
 */
- (void)syncMainSerialQueue {
    NSLog(@"%s", __func__);
    // 获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    // 同步函数执行任务
    dispatch_sync(queue, ^{
        NSLog(@"syncMainSerial1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncMainSerial2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncMainSerial3---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncMainSerial4---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncMainSerial5---%@", [NSThread currentThread]);
    });
}

/**
 *  同步函数 + 异步队列
 */
- (void)syncConcurrentQueue {
    NSLog(@"%s", __func__);
    // 自己创建的异步队列
    dispatch_queue_t queue = dispatch_queue_create("com.ivanding.concurrent", DISPATCH_QUEUE_CONCURRENT);
    // 同步函数执行任务
    dispatch_sync(queue, ^{
        NSLog(@"syncConcurrent1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncConcurrent2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncConcurrent3---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncConcurrent4---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncConcurrent5---%@", [NSThread currentThread]);
    });
}

/**
 *  同步函数 + 全局异步队列
 */
- (void)syncGlobalConcurrentQueue {
    NSLog(@"%s", __func__);
    // 获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 同步函数执行任务
    dispatch_sync(queue, ^{
        NSLog(@"syncGlobalConcurrent1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncGlobalConcurrent2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncGlobalConcurrent3---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncGlobalConcurrent4---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"syncGlobalConcurrent5---%@", [NSThread currentThread]);
    });
}


@end
