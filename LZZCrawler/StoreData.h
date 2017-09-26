//
//  StoreData.h
//  LZZCrawler
//
//  Created by Luzz on 2017/9/26.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreData : NSObject

+(NSArray *)historyUrls;
+(void)insertUrl:(NSString *)url;

@end
