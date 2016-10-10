//
//  UIButton+Vertical.m
//  20161009001-UIScrollView-CircleMenuScrollView
//
//  Created by Rainer on 2016/10/9.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "UIButton+Vertical.h"

@implementation UIButton (Vertical)

/**
 *  点击高亮（这里去除高亮功能）
 */
- (void)setHighlighted:(BOOL)highlighted {

}

/**
 *  设置图片和文字的间距
 *
 *  @param spacing    间距值
 */
- (void)verticalImageAndTitle:(CGFloat)spacing {
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{@"NSFontAttributeName" : self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
}

@end
