//
//  ViewController.m
//  GCDCommunicationDemo
//
//  Created by IvanDing on 16/5/22.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示GCD线程间通信

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 下载图片
    [self downloadImage];
}

/**
 *  下载图片
 */
- (void)downloadImage {
    // 获取默认优先级的全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 使用异步函数
    dispatch_async(queue, ^{
        // 获取url
        NSURL *url = [NSURL URLWithString:@"http://p5.img.cctvpic.com/20100107/images/1262848505292_1262848505292_r.jpg"];
        // 从url获取二进制数据(下载图片)
        NSData *data = [NSData dataWithContentsOfURL:url];
        // 将二进制数据转为图片
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"come in %@", [NSThread currentThread]);
        // 回到主队列刷新ui
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            NSLog(@"come in %@", [NSThread currentThread]);
        });
    });
}


@end
