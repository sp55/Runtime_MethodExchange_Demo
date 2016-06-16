//
//  NSString+MyCategory.m
//  Runtime_MethodExchange_Demo
//
//  Created by admin on 16/6/16.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "NSString+MyCategory.h"
#import <objc/message.h>

@implementation NSString (MyCategory)

//普通的类别
-(NSString *)my1_substringFromIndex:(NSUInteger)from{
    NSString *subStr = [self substringFromIndex:from];
    return subStr;
}


//runtime进行方法交换
- (NSString *)my2_substringFromIndex:(NSUInteger)from{
    NSString *subStr = [self my2_substringFromIndex:from];
    return subStr;
}
// 当程序一运行，所有类会被加载，这时候会调用这个方法
+ (void)load{
    //class_getInstanceMethod是获取类的对象的方法
    Method subStrMethod = class_getInstanceMethod([NSString class], @selector(substringFromIndex:));
    Method ny2_subStrMethod = class_getInstanceMethod([NSString class], @selector(my2_substringFromIndex:));
    // 交换方法实现
    method_exchangeImplementations(subStrMethod, ny2_subStrMethod);
    
}

/*
 原理：在运行的时候，当分类被加载（load方法执行）的时候，用到了运行时的交换方法实现的机制，对方法名和实现进行了对调，这里我们需要明白下面的概念：
 
 一个方法包括了 方法名 和 方法实现
 方法名: 「类型是Method」可以通过运行时的方法获取到。
 1 class_getInstanceMethod 获取对象方法的方法编号。这里可以自己用command键点进去看看系统里的，他的返回值类型是Method**类型。
 2 class_getClassMethod 获取类方法的方法编号。
 方法实现: 也就是方法具体要做的事情「类型是IMP」可以通过运行时的方法class_getMethodImplementation获取到。
 

 
获取类方法
@param cls  Class:获取哪个类方法
@param name SEL:获取方法编号,根据SEL就能去对应的类找方法
@return  Method 类方法名

OBJC_EXPORT Method class_getClassMethod(Class cls, SEL name)
__OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);


获取对象方法
@param cls  Class:获取哪个类方法
@param name SEL:获取方法编号,根据SEL就能去对应的类找方法
@return  Method 对象方法名

OBJC_EXPORT Method class_getInstanceMethod(Class cls, SEL name)
__OSX_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);


获取方法实现
@param cls  Class:获取哪个类方法
@param name SEL:获取方法编号,根据SEL就能去对应的类找方法
@return  IMP 方法实现

OBJC_EXPORT IMP class_getMethodImplementation(Class cls, SEL name)
__OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);

 
 
 
 交换方法
 对两个方法名的方法实现进行对调，在运行的时候，当调用方法时（perform之类的），原来的时候，我们调用@selector(substringFromIndex:)方法，他会自己找到他的实现，运行，但是当我们对调之后，调用@selector(substringFromIndex:)会运行@selector(ny_substringFromIndex:)的实现
 
 OBJC_EXPORT void method_exchangeImplementations(Method m1, Method m2)
 __OSX_AVAILABLE_STARTING(__MAC_10_5, __IPHONE_2_0);
 
 */

@end
