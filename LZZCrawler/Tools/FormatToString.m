//
//  FormatToString.m
//  LZZCrawler
//
//  Created by Luzz on 2017/9/26.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import "FormatToString.h"


@implementation FormatToString
+(NSString *)formatItem:(id)item
{
    
    if (!item) {
        return @"";
    }
    
    if ([item isKindOfClass:[NSArray class]]||[item isKindOfClass:[NSDictionary class]]||[item isKindOfClass:[NSString class]]) {
        NSData * data = [NSJSONSerialization dataWithJSONObject:item options:NSJSONWritingPrettyPrinted error:NULL];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }else if([item isKindOfClass:NSClassFromString(@"_NSInlineData")] || [item isKindOfClass:[NSData class]]){
        return [[NSString alloc] initWithData:item encoding:NSUTF8StringEncoding];
    }else{
        return [NSString stringWithFormat:@"unknown type : %@",NSStringFromClass([item class])];
    }
    
}
@end
