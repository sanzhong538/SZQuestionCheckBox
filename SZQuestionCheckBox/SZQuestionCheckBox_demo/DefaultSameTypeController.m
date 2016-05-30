//
//  DefaultSameTypeController.m
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/5/30.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "DefaultSameTypeController.h"
#import "SZQuestionCheckBox.h"

@interface DefaultSameTypeController ()

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *optionArray;

@property (nonatomic, strong) SZQuestionCheckBox *questionBox;

@end

@implementation DefaultSameTypeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = [NSArray arrayWithObjects:@"第一题 你感觉这个Demo如何，能否帮助到你？", @"第二题 你感觉这个Demo如何，能否帮助到你？？", @"第三题 你感觉这个Demo如何，能否帮助到你？", nil];
    self.optionArray = [NSArray arrayWithObjects:@[@"很好，正是我所需要的", @"不错，值得学习借鉴", @"一般般而已，没什么好看的", @"太Low,不忍直视", @"不知所云"], @[@"很好，正是我所需要的", @"不错，值得学习借鉴", @"一般般而已，没什么好看的", @"太Low,不忍直视", @"不知所云"], @[@"很好，正是我所需要的", @"不错，值得学习借鉴", @"一般般而已，没什么好看的", @"太Low,不忍直视", @"不知所云"], nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 有结果数组
- (IBAction)clickBtn:(UIButton *)sender {
    
    NSArray *resultArray = @[@[@"YES", @"NO", @"NO", @"NO", @"NO"], @[@"NO", @"YES", @"NO", @"NO", @"NO"], @[@"NO", @"NO", @"YES", @"NO", @"NO"]];
    SZQuestionItem *item = [[SZQuestionItem alloc] initWithTitleArray:self.titleArray andOptionArray:self.optionArray andResultArray:resultArray andQuestonType:SZQuestionSingleChoice];
    
    self.questionBox = [[SZQuestionCheckBox alloc] initWithItem:item];
    [self.navigationController pushViewController:self.questionBox animated:YES];

}

// 无结果数组
- (IBAction)clickBtnWithoutResult:(UIButton *)sender {
    
    SZQuestionItem *item = [[SZQuestionItem alloc] initWithTitleArray:self.titleArray andOptionArray:self.optionArray  andQuestonType:SZQuestionSingleChoice];
    
    self.questionBox = [[SZQuestionCheckBox alloc] initWithItem:item];
    [self.navigationController pushViewController:self.questionBox animated:YES];
}

@end
