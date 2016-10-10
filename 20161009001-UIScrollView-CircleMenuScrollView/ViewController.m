//
//  ViewController.m
//  20161009001-UIScrollView-CircleMenuScrollView
//
//  Created by Rainer on 2016/10/9.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "ViewController.h"
#import "CircleMenuScrollView.h"

@interface ViewController () <CircleMenuScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *menuButtonModelArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect circleMenuScrollViewFrame = CGRectMake(0, 64, self.view.bounds.size.width, 200);
    
    CircleMenuScrollView *circleMenuScrollView = [[CircleMenuScrollView alloc] initWithFrame:circleMenuScrollViewFrame menuButtonModelArry:self.menuButtonModelArray];
    circleMenuScrollView.delegate = self;
    
    [self.view addSubview:circleMenuScrollView];
}

- (NSMutableArray *)menuButtonModelArray {
    if (nil == _menuButtonModelArray) {
        NSMutableArray *menuButtonModelArray = [NSMutableArray array];
        
        for (int i = 0; i < 33; i++) {
            MenuButtonModel *menuButtonModel = [[MenuButtonModel alloc] init];
            
            menuButtonModel.menuName = [NSString stringWithFormat:@"菜单[%02d]", i];
            menuButtonModel.imageName = @"index-icon2";
            menuButtonModel.serverUrl = @"";
            
            [menuButtonModelArray addObject:menuButtonModel];
        }
        
        _menuButtonModelArray = menuButtonModelArray;
    }
    
    return _menuButtonModelArray;
}

- (void)circleMenuScrollView:(CircleMenuScrollView *)circleMenuScrollView didClickedActionAtIndex:(NSInteger)index {
    NSLog(@"%zd", index);
}

@end
