//
//  CircleMenuScrollView.h
//  SandLife
//
//  Created by Rainer on 16/9/27.
//  Copyright © 2016年 Sand. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 菜单按钮总行数 */
#define kTotalRow 2
/** 菜单按钮总列数 */
#define kTotalCol 4
/** 菜单按钮宽度 */
#define kMenuButtonW 60
/** 菜单按钮高度 */
#define kMenuButtonH 53
/** 菜单文字和图片间距 */
#define kTitleImageMargin 20

@class CircleMenuScrollView;

@interface MenuButtonModel : NSObject

/** 图片服务器地址 */
@property (nonatomic, copy) NSString *serverUrl;
/** 图片名称 */
@property (nonatomic, copy) NSString *imageName;
/** 菜单名称 */
@property (nonatomic, copy) NSString *menuName;

@end

@protocol CircleMenuScrollViewDelegate <NSObject>

@optional
/**
 *  点击了菜单按钮代理方法
 *
 *  @param circleAutoScrollView 滚动视图
 *  @param index                当前图片索引
 */
- (void)circleMenuScrollView:(CircleMenuScrollView *)circleMenuScrollView didClickedActionAtIndex:(NSInteger)index;

@end

@interface CircleMenuScrollView : UIView

/** 滚动菜单视图代理属性 */
@property (nonatomic, weak) id<CircleMenuScrollViewDelegate> delegate;

/**
 *  创建一个滚动菜单视图
 *
 *  @param frame           滚动菜单视图Frame
 *  @param imageModelArray 滚动菜单集合
 *
 *  @return 滚动菜单视图
 */
- (instancetype)initWithFrame:(CGRect)frame menuButtonModelArry:(NSArray<MenuButtonModel *> *)menuButtonModelArry;

/**
 *  创建一个滚动菜单视图
 *
 *  @param frame           滚动菜单视图Frame
 *  @param imageModelArray 滚动菜单集合
 *
 *  @return 滚动菜单视图
 */
+ (instancetype)circleMenuScrollViewWithFrame:(CGRect)frame menuButtonModelArry:(NSArray<MenuButtonModel *> *)menuButtonModelArry;

@end

