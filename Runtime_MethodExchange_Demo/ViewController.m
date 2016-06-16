//
//  ViewController.m
//  Runtime_MethodExchange_Demo
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 AlezJi. All rights reserved.
//
//http://www.jianshu.com/p/4ded7ee15ec1
//RunTime运用方法交换

#import "ViewController.h"
#import "NSString+MyCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



    NSString *numStr = @"123456789";
    
    NSLog(@"直接打印 = %@",[numStr substringFromIndex:2]);
    
    NSLog(@"类别 = %@",[numStr my1_substringFromIndex:2]);


    NSLog(@"类别runtime交换方法 = %@",[numStr my2_substringFromIndex:2]);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
