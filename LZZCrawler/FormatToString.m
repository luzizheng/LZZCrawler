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
    
    if ([item isKindOfClass:[NSArray class]]) {
        NSArray * arr = item;
        NSMutableString * str = [[NSMutableString alloc] init];
        
        [str appendString:@"\nArray:[\n"];
        
        for (id innerItem in arr) {
            
            NSString * innerString = [self formatItem:innerItem];
            
            [str appendFormat:@"%@\n",innerString];
            
        }
        
        [str appendString:@"]"];
        
        return str;
        
    }else if ([item isKindOfClass:[NSDictionary class]]){
        
        NSMutableString * str = [[NSMutableString alloc] init];
        
        [str appendString:@"\nDictionary:{\n"];
        
        NSDictionary * dic = item;
        NSArray * keys = [[dic allKeys] copy];
        
        for (NSString * key in keys) {
            
            id dicItem = [dic objectForKey:key];
            
            [str appendFormat:@"%@ ==> %@\n",key,[self formatItem:dicItem]];
            
            
        }
        
        [str appendString:@"}"];
        
        return str;
        
        
        
    }else if([item isKindOfClass:[NSString class]]){
        
        return item;
    
    
    }else{
        return @"unknownClass";
    }
    
    
}
@end
