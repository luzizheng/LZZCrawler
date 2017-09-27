//
//  UINavigationItem+CustomBackButton.m
//  LZZCrawler
//
//  Created by Luzz on 2017/9/27.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import "UINavigationItem+CustomBackButton.h"
#import <objc/runtime.h>

@implementation UINavigationItem (CustomBackButton)

//+(void)load{
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Method originalMethodImp = class_getInstanceMethod(self, @selector(backBarButtonItem));
//        Method destMethodImp = class_getInstanceMethod(self, @selector(myCustomBackButton_backBarbuttonItem));
//        method_exchangeImplementations(originalMethodImp, destMethodImp);
//    });
//}

-(UIBarButtonItem *)backBarButtonItem{
    return [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
}

//static char kCustomBackButtonKey;
//-(UIBarButtonItem *)myCustomBackButton_backBarbuttonItem{
//    UIBarButtonItem *item = [self myCustomBackButton_backBarbuttonItem];
//    if (item) {
//        return item;
//    }
//    item = objc_getAssociatedObject(self, &kCustomBackButtonKey);
//    if (!item) {
//        item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
//        objc_setAssociatedObject(self, &kCustomBackButtonKey, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    return item;
//}
//
//- (void)dealloc {
//    objc_removeAssociatedObjects(self);
//}

@end
