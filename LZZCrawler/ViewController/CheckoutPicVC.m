//
//  CheckoutPicVC.m
//  LZZCrawler
//
//  Created by Luzz on 2017/9/27.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import "CheckoutPicVC.h"
#import "HZPhotoBrowserHeader.h"
#import "LZZCrawlerTool.h"

@interface CheckoutPicVC ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation CheckoutPicVC



- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpUI
{
    
    [LZZCrawlerTool grabHTMLWithDocument:self.htmlDocument andXPath:@"//img[@src]" andCompletion:^(BOOL successed, id resData, NSError *error) {
        if (successed) {
            
            
            HZPhotoGroup *photoGroup = [[HZPhotoGroup alloc] init];
            NSMutableArray *temp = [NSMutableArray array];
            [resData enumerateObjectsUsingBlock:^(NSDictionary *dic, NSUInteger idx, BOOL *stop) {
                HZPhotoItem *item = [[HZPhotoItem alloc] init];
                item.thumbnail_pic = [dic objectForKey:@"src"];
                [temp addObject:item];
            }];
            photoGroup.photoItemArray = [temp copy];
            __weak typeof(self.scrollView)weakScrollView = self.scrollView;
            photoGroup.layoutSubViewsHandler = ^(CGRect frame) {
                __strong typeof(weakScrollView)strongScrollView = weakScrollView;
                [strongScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, frame.size.height+50)];
                
            };
            [self.scrollView addSubview:photoGroup];
            
            
            
        }
    }];
    
    
    
    
    
}
@end
