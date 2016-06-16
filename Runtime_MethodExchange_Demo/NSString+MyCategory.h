//
//  NSString+MyCategory.h
//  Runtime_MethodExchange_Demo
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MyCategory)

//类别
- (NSString *)my1_substringFromIndex:(NSUInteger)from;


//runtime进行方法交换
- (NSString *)my2_substringFromIndex:(NSUInteger)from;

@end
