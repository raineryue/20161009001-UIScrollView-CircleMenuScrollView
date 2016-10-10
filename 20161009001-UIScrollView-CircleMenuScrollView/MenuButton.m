//
//  MenuButton.m
//  20161009001-UIScrollView-CircleMenuScrollView
//
//  Created by Rainer on 2016/10/10.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "MenuButton.h"

@implementation MenuButton

/**
 *  点击高亮（这里用来去掉此功能）
 */
- (void)setHighlighted:(BOOL)highlighted {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{@"NSFontAttributeName" : self.titleLabel.font}];
    
    CGFloat imageViewX = 0;
    CGFloat imageViewY = 0;
    CGFloat imageViewW = self.bounds.size.width;
    CGFloat imageViewH = self.bounds.size.height - textSize.height;
    
    self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
    
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.imageView.frame) + 7;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = textSize.height;
    
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
}

@end
