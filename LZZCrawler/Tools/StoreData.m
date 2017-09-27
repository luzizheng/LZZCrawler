//
//  StoreData.m
//  LZZCrawler
//
//  Created by Luzz on 2017/9/26.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import "StoreData.h"

@implementation StoreData
+(NSArray *)historyUrls
{
    NSArray * arr = [[NSUserDefaults standardUserDefaults] objectForKey:@"historyUrls"];
    if (arr) {
        return arr;
    }else{
        return [NSArray array];
    }
}

+(void)insertUrl:(NSString *)url
{
    
    if (url && url.length>0) {
        NSMutableArray * preArr = [NSMutableArray arrayWithArray:[self historyUrls]];
        
        BOOL contain = NO;
        for (NSString * innerUrl in preArr) {
            
            if ([innerUrl isEqualToString:url]) {
                contain = YES;
            }
        }
        
        if (contain == NO) {
            [preArr addObject:url];
            [[NSUserDefaults standardUserDefaults] setObject:preArr forKey:@"historyUrls"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        
    }
    
    
    
    
}


@end
