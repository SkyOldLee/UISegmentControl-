//
//  XCFristController.m
//  segmentControll实现控制器的切换
//
//  Created by 小蔡 on 16/3/7.
//  Copyright © 2016年 xiaocai. All rights reserved.
//

#import "XCFristController.h"

@implementation XCFristController
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"fristController";
    label.font = [UIFont systemFontOfSize:17];
    label.frame = CGRectMake(100, 100, 200, 100);
    [self.view addSubview:label];
}
@end
