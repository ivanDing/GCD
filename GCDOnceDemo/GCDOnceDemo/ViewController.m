//
//  ViewController.m
//  GCDOnceDemo
//
//  Created by IvanDing on 16/5/30.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示GCD中dispatch_once的使用

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击了");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"该行代码只执行一次");
    });
}

@end
