//
//  XCMainController.m
//  segmentControll实现控制器的切换
//
//  Created by 小蔡 on 16/3/7.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "XCMainController.h"
#import "XCFristController.h"
#import "XCSecondController.h"

#define mainVcWidth self.view.frame.size.width
#define mainVcHeight self.view.frame.size.height
#define navigationHeight 64

@interface XCMainController()
//子控制器一定要用strong来修饰，否则会被释放
@property (nonatomic, strong) XCFristController *fristVc;
@property (nonatomic, strong) XCSecondController *secondVc;
//当前选中的控制器
@property (nonatomic, strong) UIViewController *currentVC;
@end

@implementation XCMainController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.navigationItem.titleView = [self setupSegment];
    
    self.fristVc = [[XCFristController alloc] init];
    self.fristVc.view.frame = CGRectMake(0, navigationHeight, mainVcWidth, mainVcHeight - 64);
    [self addChildViewController:_fristVc];
    
    self.secondVc = [[XCSecondController alloc] init];
    self.secondVc.view.frame = CGRectMake(0, navigationHeight, mainVcWidth, mainVcHeight - 64);
    [self addChildViewController:_secondVc];
    
    //设置默认控制器为fristVc
    self.currentVC = self.fristVc;
    [self.view addSubview:self.fristVc.view];
    
}

/**
 *  初始化segmentControl
 */
- (UISegmentedControl *)setupSegment{
    NSArray *items = @[@"1", @"2"];
    UISegmentedControl *sgc = [[UISegmentedControl alloc] initWithItems:items];
    //默认选中的位置
    sgc.selectedSegmentIndex = 0;
    //设置segment的文字
    [sgc setTitle:@"oneView" forSegmentAtIndex:0];
    [sgc setTitle:@"twoView" forSegmentAtIndex:1];
    //监听点击
    [sgc addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged];
    return sgc;
}

- (void)segmentChange:(UISegmentedControl *)sgc{
    //NSLog(@"%ld", sgc.selectedSegmentIndex);
    switch (sgc.selectedSegmentIndex) {
        case 0:
            [self replaceFromOldViewController:self.secondVc toNewViewController:self.fristVc];
            break;
        case 1:
            [self replaceFromOldViewController:self.fristVc toNewViewController:self.secondVc];
            break;
        default:
            break;
    }
}

- (void)replaceFromOldViewController:(UIViewController *)oldVc toNewViewController:(UIViewController *)newVc{
    /**
     *  transitionFromViewController:toViewController:duration:options:animations:completion:
     *  fromViewController	  当前显示在父视图控制器中的子视图控制器
     *  toViewController		将要显示的姿势图控制器
     *  duration				动画时间(这个属性,old friend 了 O(∩_∩)O)
     *  options				 动画效果(渐变,从下往上等等,具体查看API)UIViewAnimationOptionTransitionCrossDissolve
     *  animations			  转换过程中得动画
     *  completion			  转换完成
     */
    [self addChildViewController:newVc];
    [self transitionFromViewController:oldVc toViewController:newVc duration:0.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newVc didMoveToParentViewController:self];
            [oldVc willMoveToParentViewController:nil];
            [oldVc removeFromParentViewController];
            self.currentVC = newVc;
        }else{
            self.currentVC = oldVc;
        }
    }];
}


@end
