//
//  UIView+copyView.m
//  LZZCrawler
//
//  Created by Luzz on 2017/9/26.
//  Copyright © 2017年 LZZ. All rights reserved.
//

#import "UIView+copyView.h"




@implementation UIView (copyView)
-(id)copyView
{
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel * originLabel = (UILabel *)self;
        UILabel * label = [[UILabel alloc] initWithFrame:originLabel.frame];
        label.backgroundColor = originLabel.backgroundColor;
        label.text = originLabel.text;
        label.textColor = originLabel.textColor;
        label.textAlignment = originLabel.textAlignment;
        label.font = originLabel.font;
        return label;
    }else{
        return self;
    }
}
@end
