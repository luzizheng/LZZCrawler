//
//  LZZCrawlerTool.h
//  LZZCrawler
//
//  Created by Luzz on 2017/9/25.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LZZCrawlerTool : NSObject

/**
 get html document
 */
+(void)getHTMLDocumentWithUrl:(NSString *)url
                    andParams:(NSSet *)parmas
                andCompletion:(void (^)(BOOL successed,id responseObject,NSError * error))completion;


+(void)grabHTMLWithUrl:(NSString *)url
            withParams:(NSSet *)parmas
              andXPath:(NSString *)xPath
         andCompletion:(void (^)(BOOL successed,id resData,NSError * error))completion;


+(void)grabHTMLWithDocument:(id)htmlDocument
                   andXPath:(NSString *)xPath
              andCompletion:(void (^)(BOOL successed,id resData,NSError * error))completion;

+(void)cancelAllReqTask;
@end
