//
//  LZZButton.m
//  LZZCrawler
//
//  Created by Luzz on 2017/9/26.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import "LZZButton.h"
#import <DownloadButton/UIImage+PKDownloadButton.h>

static UIColor * lzzDefBtnColor(){
    return [UIColor whiteColor];
}


static NSDictionary *LZZDefaultTitleAttributes() {
    return @{ NSForegroundColorAttributeName : lzzDefBtnColor(),
              NSFontAttributeName : [UIFont systemFontOfSize:14.f]};
}

static NSDictionary *LZZHighlitedTitleAttributes() {
    return @{ NSForegroundColorAttributeName : [UIColor darkGrayColor],
              NSFontAttributeName : [UIFont systemFontOfSize:14.f]};
}



@implementation LZZButton


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        [self configStyle];
        
    }
    return self;
}


-(void)configStyle
{
    
    for (id obj in self.subviews) {
        
        if ([obj isKindOfClass:[UIButton class]]) {
            UIButton * btn = obj;
            if ([btn.currentAttributedTitle.string isEqualToString:@"DOWNLOAD"]) {
                [self configBtnBG:btn];
                
            }
            
        }
        
        if ([obj isKindOfClass:[PKPendingView class]]) {
            PKPendingView * pView = obj;
            pView.tintColor = [UIColor whiteColor];
        }
        
        
    }
    
}


-(void)configBtnBG:(UIButton *)btn
{
    [btn setBackgroundImage:nil forState:UIControlStateNormal];
    [btn setBackgroundImage:nil forState:UIControlStateHighlighted];
    UIImage *backImage = [UIImage buttonBackgroundWithColor:lzzDefBtnColor()];
    [btn setBackgroundImage:[backImage resizableImageWithCapInsets:UIEdgeInsetsMake(15.f, 15.f, 15.f, 15.f)]
                    forState:UIControlStateNormal];
    
    [btn setBackgroundImage:[UIImage highlitedButtonBackgroundWithColor:lzzDefBtnColor()]
                    forState:UIControlStateHighlighted];
    
    NSAttributedString *title = [[NSAttributedString alloc] initWithString:@"GRAB" attributes:LZZDefaultTitleAttributes()];
    [btn setAttributedTitle:title forState:UIControlStateNormal];
    NSAttributedString *highlitedTitle = [[NSAttributedString alloc] initWithString:@"GRAB" attributes:LZZHighlitedTitleAttributes()];
    [btn setAttributedTitle:highlitedTitle forState:UIControlStateHighlighted];
    
}




@end
