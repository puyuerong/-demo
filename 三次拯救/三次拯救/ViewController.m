//
//  ViewController.m
//  三次拯救
//
//  Created by 蒲悦蓉 on 2020/8/5.
//  Copyright © 2020 蒲悦蓉. All rights reserved.
//

#import "ViewController.h"
#import "objc/runtime.h"
#import "person.h"


@interface ViewController ()
@property UIButton *secondRescueBut;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(100, 100, 300, 100);
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn setTitle:@"第一次拯救——动态方法解析" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(theFirstRescue:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn2.frame = CGRectMake(100, 300, 300, 100);
    btn2.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn2 setTitle:@"第二次拯救——动态方法解析" forState:UIControlStateNormal];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(theSecondRescue) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn3.frame = CGRectMake(100, 500, 300, 100);
    btn3.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn3 setTitle:@"第三次拯救——动态方法解析" forState:UIControlStateNormal];
    [self.view addSubview:btn3];
    [btn3 addTarget:self action:@selector(theThirdRescue) forControlEvents:UIControlEventTouchUpInside];
}

void theFirstRescueMethod() {
    NSLog(@"theFirstRescueSucceeded!");
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(theFirstRescue:)) {
        class_addMethod([self class], sel, (IMP)theFirstRescueMethod, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(theSecondRescue)) {
        return [[person alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(theThirdRescue)) {
        return [NSMethodSignature signatureWithObjCTypes:"i20@0:8i16"];
    }
    return [super methodSignatureForSelector:aSelector];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"theThirdRescueSucceeded!");
}
@end
