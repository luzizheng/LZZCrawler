//
//  NSString+smartUrl.m
//  LZZCrawler
//
//  Created by Luzz on 2017/9/27.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import "NSString+smartUrl.h"

@implementation NSString (smartUrl)
-(NSString *)smartUrl
{
    if (![self hasPrefix:@"https://"] && ![self hasPrefix:@"http://"]) {
        return [NSString stringWithFormat:@"https://%@",self];
    }
    return self;
}
@end
