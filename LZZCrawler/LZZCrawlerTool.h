//
//  LZZCrawlerTool.h
//  LZZCrawler
//
//  Created by Luzz on 2017/9/25.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZZCrawlerTool : NSObject
+(void)grabHTMLWithUrl:(NSString *)url
            withParams:(NSSet *)parmas
              andXPath:(NSString *)xPath
         andCompletion:(void (^)(BOOL successed,id resData,NSError * error))completion;

+(void)cancelAllReqTask;
@end
