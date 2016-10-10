//
//  CircleMenuScrollView.m
//  SandLife
//
//  Created by Rainer on 16/9/27.
//  Copyright © 2016年 Sand. All rights reserved.
//

#import "CircleMenuScrollView.h"
#import "UIButton+Vertical.h"
#import "MenuButton.h"

@implementation MenuButtonModel

@end

@interface CircleMenuScrollView () <UIScrollViewDelegate>

/** 滚动视图 */
@property (nonatomic, strong) UIScrollView *buttonScrollView;
/** 分页控件 */
@property (nonatomic, strong) UIPageControl *pageControl;

/** 数据源 */
@property (nonatomic, strong) NSArray *menuButtonModelArry;
/** 总页数 */
@property (nonatomic, assign) NSInteger pageCount;

@end

@implementation CircleMenuScrollView
/**
 *  创建一个滚动菜单视图
 *
 *  @param frame           滚动菜单视图Frame
 *  @param imageModelArray 滚动菜单集合
 *
 *  @return 滚动菜单视图
 */
- (instancetype)initWithFrame:(CGRect)frame menuButtonModelArry:(NSArray<MenuButtonModel *> *)menuButtonModelArry {
    if (self = [super initWithFrame:frame]) {
        // 1.设置图片滚动视图的Frame
        self.buttonScrollView.frame = self.frame;
        self.menuButtonModelArry = menuButtonModelArry;
        
        // 2.设置图片滚动视图的contentSize
        [self setupScrollViewProperties];
        
        // 3.循环添加图片到滚动视图中
        [self setupMenuButtonItemsView];
        
        // 4.初始化分页控件页数
        self.pageControl.currentPage = 0;
    }
    
    return self;
}

/**
 *  创建一个滚动菜单视图
 *
 *  @param frame           滚动菜单视图Frame
 *  @param imageModelArray 滚动菜单集合
 *
 *  @return 滚动菜单视图
 */
+ (instancetype)circleMenuScrollViewWithFrame:(CGRect)frame menuButtonModelArry:(NSArray<MenuButtonModel *> *)menuButtonModelArry {
    return [[self alloc] initWithFrame:frame menuButtonModelArry:menuButtonModelArry];
}

#pragma mark - 私有辅助方法
/**
 *  设置滚动视图的内容属性
 */
- (void)setupScrollViewProperties {
    // 2.1.计算总页数
    int otherCount = self.menuButtonModelArry.count % (kTotalCol * kTotalRow) > 0 ? 1 : 0;
    
    self.pageCount = self.menuButtonModelArry.count / (kTotalCol * kTotalRow) + otherCount;
    
    // 2.2.计算内容大小
    CGFloat buttonScrollViewContentW = self.buttonScrollView.bounds.size.width * self.pageCount;
    CGFloat buttonScrollViewContentH = 0;
    
    self.buttonScrollView.contentSize = CGSizeMake(buttonScrollViewContentW, buttonScrollViewContentH);
}

- (void)setupMenuButtonItemsView {
    // 计算菜单按钮的宽高间距
    CGFloat menuButtonMarginW = (self.bounds.size.width - (kTotalCol * kMenuButtonW)) / (kTotalCol + 1);
    CGFloat menuButtonMarginH = (self.bounds.size.height - (kTotalRow * kMenuButtonH) - CGRectGetHeight(self.pageControl.frame) + 20) / (kTotalRow + 1);
    
    for (int i = 0; i < self.menuButtonModelArry.count; i++) {
        // 1.当前行和列,页数
        NSInteger currentRow = i / kTotalCol;
        NSInteger currentCol = i % kTotalCol;
        NSInteger currentPage = i / (kTotalCol * kTotalRow);
        
        // 2.取出当前数据
        MenuButtonModel *buttonModel = self.menuButtonModelArry[i];
        
        // 3.1.创建菜单按钮
        MenuButton *menuButton = [MenuButton buttonWithType:UIButtonTypeCustom];
        
        [menuButton setImage:[UIImage imageNamed:buttonModel.imageName] forState:UIControlStateNormal];
        [menuButton setTitle:buttonModel.menuName forState:UIControlStateNormal];
        
        [menuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [menuButton.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        
        // 3.2.设置图片位置
        CGFloat menuButtonX = menuButtonMarginW + (menuButtonMarginW + kMenuButtonW) * currentCol + (currentPage * self.bounds.size.width);
        CGFloat menuButtonY = menuButtonMarginH + (menuButtonMarginH + kMenuButtonH) * (currentRow % kTotalRow);
        
        menuButton.frame = CGRectMake(menuButtonX, menuButtonY, kMenuButtonW, kMenuButtonH);
        menuButton.tag = i;
        menuButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        menuButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
//        [menuButton verticalImageAndTitle:8.0];

        [menuButton addTarget:self action:@selector(menuButtonClickedAction:) forControlEvents:UIControlEventTouchUpInside];
        
        // 3.3.将图片视图添加到滚动视图上
        [self.buttonScrollView addSubview:menuButton];
    }
    
}

#pragma mark - 控件懒加载
/**
 *  懒加载创建图片滚动视图
 */
- (UIScrollView *)buttonScrollView {
    if (nil == _buttonScrollView) {
        // 创建滚动视图
        UIScrollView *buttonScrollView = [[UIScrollView alloc] init];
        
        buttonScrollView.backgroundColor = [UIColor greenColor];
        
        // 设置滚动试图滚动条
        buttonScrollView.showsHorizontalScrollIndicator = NO;
        buttonScrollView.showsVerticalScrollIndicator = NO;
        
        // 设置滚动视图分页
        buttonScrollView.pagingEnabled = YES;
        
        // 设置代理
        buttonScrollView.delegate = self;
        
        // 弹簧效果设置
        buttonScrollView.bounces = NO;
        
        // 添加到控制器跟视图上
        _buttonScrollView = buttonScrollView;
        
        [self addSubview:_buttonScrollView];
    }
    
    return _buttonScrollView;
}

/**
 *  懒加载分页控件
 */
- (UIPageControl *)pageControl {
    if (nil == _pageControl) {
        // 1.创建分页控件
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        
        // 2.设置总页数
        pageControl.numberOfPages = _pageCount;
        
        // 3.设置分页控件的位置大小
        CGSize pageSize = [pageControl sizeForNumberOfPages:pageControl.numberOfPages];
        
        pageControl.bounds = (CGRect){CGPointZero, pageSize};
        pageControl.center = CGPointMake(self.buttonScrollView.center.x, CGRectGetMaxY(self.buttonScrollView.frame) - 10);
        
        // 4.设置分页按钮的颜色
        pageControl.pageIndicatorTintColor = [UIColor grayColor];
        pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
        
        // 5.添加分页控件值改变事件监听方法
        [pageControl addTarget:self action:@selector(pageControlValueChangedAction:) forControlEvents:UIControlEventValueChanged];
        
        // 6.将分页控件添加到控制器根视图上
        _pageControl = pageControl;
        
        [self addSubview:_pageControl];
    }
    
    return _pageControl;
}

#pragma mark - 事件监听方法处理
/**
 *  分页控件值改变事件处理
 */
- (void)pageControlValueChangedAction:(UIPageControl *)pageControl {
    // 1.获取当前页数
    NSInteger currentPage = pageControl.currentPage;
    
    // 2.判断当前页数是否为最大页：如果是从0开始，不是就＋＋到下一页
    if (currentPage == _pageCount - 1)
        currentPage = 0;
    else
        currentPage++;
    
    // 3.取出当前滚动视图的宽度
    CGFloat scrollViewW = self.buttonScrollView.bounds.size.width;
    
    // 4.添加动画设置滚动视图的偏移量：实现点击分页按钮滚动图片
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    
    self.buttonScrollView.contentOffset = CGPointMake(scrollViewW * currentPage, 0);
    
    [UIView commitAnimations];
}

/**
 *  图片点击手势事件处理
 *
 *  @param panGestureRecognizer 点击手势
 */
- (void)menuButtonClickedAction:(UIButton *)menuButton {
    if ([self.delegate respondsToSelector:@selector(circleMenuScrollView:didClickedActionAtIndex:)]) {
        [self.delegate circleMenuScrollView:self didClickedActionAtIndex:menuButton.tag];
    }
}

#pragma mark - 代理方法事件处理
/**
 *  滚动视图“滚动中”代理方法
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 1.取出当前滚动视图X方向上的偏移量
    CGFloat contentOffSetX = scrollView.contentOffset.x;
    
    // 2.取出当前滚动视图的宽度
    CGFloat scrollViewW = scrollView.bounds.size.width;
    
    // 3.计算出当前页数:当前页数 = （偏移量 ＋ 滚动视图宽度的一半） / 滚动视图的宽度
    int currentPage = (contentOffSetX + scrollViewW * 0.5) / scrollViewW;
    
    // 4.设置分页控件当前的页数
    self.pageControl.currentPage = currentPage;
}

@end
