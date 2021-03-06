//
//  LZZCrawlerTool.m
//  LZZCrawler
//
//  Created by Luzz on 2017/9/25.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import "LZZCrawlerTool.h"
#import <AFNetworking/AFNetworking.h>
#import <Ono/Ono.h>


@interface LZZTaskBox : NSObject
SYNTHESIZE_SINGLETON_FOR_CLASS_HEADER(LZZTaskBox)
@property(nonatomic,strong,readonly)NSMutableSet <NSURLSessionDataTask *>* registerTasks;
-(void)stopAllTask;
@end

@implementation LZZTaskBox
SYNTHESIZE_SINGLETON_FOR_CLASS(LZZTaskBox)
@synthesize registerTasks = _registerTasks;
-(NSMutableSet *)registerTasks
{
    if (!_registerTasks) {
        _registerTasks = [NSMutableSet set];
    }
    return _registerTasks;
}
-(void)stopAllTask
{
    for (NSURLSessionDataTask * task in self.registerTasks) {
        [task cancel];
    }
    [self.registerTasks removeAllObjects];
}


@end


@implementation LZZCrawlerTool
+(void)getHTMLDocumentWithUrl:(NSString *)url
                    andParams:(NSSet *)parmas
                andCompletion:(void (^)(BOOL successed,id responseObject,NSError * error))completion
{
    
    [[LZZTaskBox sharedInstance] stopAllTask];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    NSURLSessionDataTask * task = [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (completion) {
            completion(YES,responseObject,nil);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (completion) {
            completion(NO,nil,error);
        }
    }];
    [[LZZTaskBox sharedInstance].registerTasks addObject:task];
    
}

+(void)grabHTMLWithDocument:(id)htmlDocument
                   andXPath:(NSString *)xPath
              andCompletion:(void (^)(BOOL successed,id resData,NSError * error))completion
{
    NSError *readingError;
    NSMutableArray * tmpBox = [NSMutableArray array];
    ONOXMLDocument *document = [ONOXMLDocument HTMLDocumentWithData:htmlDocument error:&readingError];
    [document enumerateElementsWithXPath:xPath usingBlock:^(ONOXMLElement *element, NSUInteger idx, BOOL *stop) {
        [tmpBox addObject:element.attributes];
    }];
    if (completion) {
        if (readingError) {
            completion(NO,nil,readingError);
        }else{
            completion(YES,tmpBox,nil);
        }
    }
    
}

+(void)grabHTMLWithUrl:(NSString *)url
            withParams:(NSSet *)parmas
              andXPath:(NSString *)xPath
         andCompletion:(void (^)(BOOL successed,id resData,NSError * error))completion
{
    
    [self getHTMLDocumentWithUrl:url andParams:parmas andCompletion:^(BOOL successed, id responseObject, NSError *error) {
        if (successed) {
            [self grabHTMLWithDocument:responseObject andXPath:xPath andCompletion:^(BOOL successed, id resData, NSError *error) {
                if (completion) {
                    completion(successed,resData,error);
                }
            }];
        }else{
            if (completion) {
                completion(NO,nil,error);
            }
        }
    }];
}

+(void)cancelAllReqTask
{
    [[LZZTaskBox sharedInstance] stopAllTask];
}

@end

