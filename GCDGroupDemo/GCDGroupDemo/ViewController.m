//
//  ViewController.m
//  GCDGroupDemo
//
//  Created by IvanDing on 16/5/24.
//  Copyright © 2016年 IvanDing. All rights reserved.
//
//  此demo用于展示GCD中dispatch_group的使用

#import "ViewController.h"

#define kGetGlobalQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define KGetMainQueue dispatch_get_main_queue()

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;

@property (nonatomic, strong) UIImage * image1;
@property (nonatomic, strong) UIImage * image2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [self waitDemo];
//    [self dispatchGroupWaitDownloadPic];
//    [self dispatchGroupNotifyDownloadPic];
    [self dispatchGroupEnterAndLeaveDownloadPic];
}

/**
 *  使用wait函数demo
 */
- (void)waitDemo {
    //创建队列
    dispatch_queue_t queue1 = dispatch_queue_create("com.queue1", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t queue2 = dispatch_queue_create("com.queue2", DISPATCH_QUEUE_CONCURRENT);
    //创建队列组
    dispatch_group_t group = dispatch_group_create();
    //异步函数执行队列1的任务
    dispatch_async(queue1, ^{
        NSLog(@"task1 --- %@", [NSThread currentThread]);
    });
    //异步函数执行队列2的任务
    dispatch_async(queue2, ^{
        NSLog(@"task2 --- %@", [NSThread currentThread]);
    });
    //将队列1加入队列组
    dispatch_group_async(group, queue1, ^{
        //挂起队列1
        dispatch_suspend(queue1);
        NSLog(@"task1 finished! --- %@", [NSThread currentThread]);
    });
    //将队列2加入队列组
    dispatch_group_async(group, queue2, ^{
        //挂起队列2
        dispatch_suspend(queue2);
        NSLog(@"task2 finished! --- %@", [NSThread currentThread]);
    });
    //等待队列组任务执行
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    //异步函数执行队列3的任务
    dispatch_async(queue1, ^{
        NSLog(@"task3 --- %@", [NSThread currentThread]);
    });
    //异步函数执行队列4的任务
    dispatch_async(queue2, ^{
        NSLog(@"task4 --- %@", [NSThread currentThread]);
    });
    //恢复队列1
    dispatch_resume(queue1);
    //恢复队列2
    dispatch_resume(queue2);
}

/**
 *  队列组wait等待下载结束
 */
- (void)dispatchGroupWaitDownloadPic {
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, kGetGlobalQueue, ^{
        NSLog(@"downloading in queue1 begin");
        // 下载图片1
        self.image1 = [self downloadImageWithUrlStr:@"http://attimg.dospy.com/img/day_141110/20141110_7ff16034289d3aac30c3ttvv7R1qtIua.jpg"];
        NSLog(@"downloading in queue1 end");
    });
    dispatch_group_async(group, kGetGlobalQueue, ^{
        NSLog(@"downloading in queue2 begin");
        // 下载图片2
        self.image2 = [self downloadImageWithUrlStr:@"http://attimg.dospy.com/img/day_141110/20141110_5a3cf0b3be54176f6975Rct5srdjy22J.jpg"];
        NSLog(@"downloading in queue2 end");
    });
    
    // 等待队列组关联的任务执行完毕
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_async(kGetGlobalQueue, ^{
        // 合成图片
        UIImage *image = [self synthesisPicWithImage:self.image1 image:self.image2];
        // 刷新UI
        dispatch_async(KGetMainQueue, ^{
            self.imageView1.image = self.image1;
            self.imageView2.image = self.image2;
            self.imageView3.image = image;
        });
    });
}

/**
 *  队列组notify等待下载结束
 */
- (void)dispatchGroupNotifyDownloadPic {
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_async(group, kGetGlobalQueue, ^{
        NSLog(@"downloading in queue1 begin");
        // 下载图片1
        self.image1 = [self downloadImageWithUrlStr:@"http://attimg.dospy.com/img/day_141110/20141110_7ff16034289d3aac30c3ttvv7R1qtIua.jpg"];
        NSLog(@"downloading in queue1 end");
    });
    dispatch_group_async(group, kGetGlobalQueue, ^{
        NSLog(@"downloading in queue2 begin");
        // 下载图片2
        self.image2 = [self downloadImageWithUrlStr:@"http://attimg.dospy.com/img/day_141110/20141110_5a3cf0b3be54176f6975Rct5srdjy22J.jpg"];
        NSLog(@"downloading in queue2 end");
    });
    
    // 等待队列组关联的任务执行完毕
    dispatch_group_notify(group, kGetGlobalQueue, ^{
        // 合成图片
        UIImage *image = [self synthesisPicWithImage:self.image1 image:self.image2];
        // 刷新UI
        dispatch_async(KGetMainQueue, ^{
            self.imageView1.image = self.image1;
            self.imageView2.image = self.image2;
            self.imageView3.image = image;
        });
    });
}

/**
 *  下载图片
 *
 *  @param urlStr 图片地址
 *
 *  @return 图片
 */
- (UIImage *)downloadImageWithUrlStr:(NSString *)urlStr {
    // 获取url
    NSURL *url = [NSURL URLWithString:urlStr];
    // 下载二进制数据
    NSData *data = [NSData dataWithContentsOfURL:url];
    // 将二进制转为图片
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

/**
 *  合成图片
 *
 *  @param image1 图片1
 *  @param image2 图片2
 *
 *  @return 合成后图片
 */
- (UIImage *)synthesisPicWithImage:(UIImage *)image1 image:(UIImage *)image2 {
    // 合并图片
    UIGraphicsBeginImageContext(CGSizeMake(200, 100));
    [image1 drawInRect:CGRectMake(0, 0, 100, 100)];
    [image2 drawInRect:CGRectMake(100, 0, 100, 100)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    return image;
}

/**
 *  队列组EnterAndLeave等待下载结束
 */
- (void)dispatchGroupEnterAndLeaveDownloadPic {
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    
    //加任务到队列组
    dispatch_group_enter(group);
    dispatch_async(kGetGlobalQueue, ^{
        NSLog(@"downloading in queue1 begin");
        // 下载图片1
        self.image1 = [self downloadImageWithUrlStr:@"http://attimg.dospy.com/img/day_141110/20141110_7ff16034289d3aac30c3ttvv7R1qtIua.jpg"];
        NSLog(@"downloading in queue1 end");
        //离开队列组
        dispatch_group_leave(group);
    });

    //加任务到队列组
    dispatch_group_enter(group);
    dispatch_async(kGetGlobalQueue, ^{
        NSLog(@"downloading in queue2 begin");
        // 下载图片2
        self.image2 = [self downloadImageWithUrlStr:@"http://attimg.dospy.com/img/day_141110/20141110_5a3cf0b3be54176f6975Rct5srdjy22J.jpg"];
        NSLog(@"downloading in queue2 end");
        //离开队列组
        dispatch_group_leave(group);
    });
    
    // 等待队列组关联的任务执行完毕
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    dispatch_async(kGetGlobalQueue, ^{
        // 合成图片
        UIImage *image = [self synthesisPicWithImage:self.image1 image:self.image2];
        // 刷新UI
        dispatch_async(KGetMainQueue, ^{
            self.imageView1.image = self.image1;
            self.imageView2.image = self.image2;
            self.imageView3.image = image;
        });
    });
}
@end
