//
//  ShowViewController.m
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/5/26.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "ShowViewController.h"
#import "SZQuestionCheckBox.h"


@interface ShowViewController ()

@property (nonatomic, strong) SZQuestionCheckBox *questionBox;
@property (nonatomic, strong) SZQuestionItem *item;

@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titleArray = [NSArray arrayWithObjects:@"第一题 你感觉这个Demo如何，能否帮助到你？", @"第二题 你感觉程序员是一群什么样的人？", @"第三题 作为程序员你最想对程序说的一句话是", nil];
    NSArray *optionArray = [NSArray arrayWithObjects:@[@"很好，正是我所需要的", @"不错，值得学习借鉴", @"一般般而已，没什么好看的", @"太Low,不忍直视", @"不知所云"], @[@"最帅的", @"有钱途的", @"富有创造力", @"有梦想的", @"费脑的", @"坑爹的"], @[], nil];
    NSArray *typeArray = @[@(1), @(2), @(3)];
    
    NSArray *selectArray = [NSArray arrayWithObjects:@[@"YES", @"NO", @"NO", @"NO", @"NO"], @[@"YES", @"YES", @"YES", @"YES", @"NO", @"NO"], @"程序是我的第二生命，给了我梦想，给了我生活，给了我乐趣，所以程序你值得拥有", nil];
    self.item = [[SZQuestionItem alloc] initWithTitleArray:titleArray andOptionArray:optionArray andResultArray:selectArray andQuestonTypes:typeArray];
}

- (IBAction)showQuestionWithoutHeader:(UIButton *)sender {

    self.questionBox = [[SZQuestionCheckBox alloc] initWithItem:self.item];
    self.questionBox.canEdit = NO;
    [self.navigationController pushViewController:self.questionBox animated:YES];
}

- (IBAction)showQuestionWithHeader:(UIButton *)sender {
    
    self.questionBox = [[SZQuestionCheckBox alloc] initWithItem:self.item andCheckBoxType:QuestionCheckBoxWithHeader];
    self.questionBox.canEdit = NO;
    [self.navigationController pushViewController:self.questionBox animated:YES];
}


@end
