//
//  SetFrameViewController.m
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/5/27.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "SetFrameViewController.h"
#import "SZQuestionCheckBox.h"

@interface SetFrameViewController ()

@property (nonatomic, strong) SZQuestionItem *item;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *optionArray;

@property (nonatomic, strong) NSArray *typeArray;

@end

@implementation SetFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = [NSArray arrayWithObjects:@"第一题 你感觉这个Demo如何，能否帮助到你？", @"第二题 你感觉程序员是一群什么样的人？", @"第三题 作为程序员你最想对程序说的一句话是", nil];
    self.optionArray = [NSArray arrayWithObjects:@[@"很好，正是我所需要的", @"不错，值得学习借鉴", @"一般般而已，没什么好看的", @"太Low,不忍直视", @"不知所云"], @[@"最帅的", @"有钱途的", @"富有创造力", @"有梦想的", @"费脑的", @"坑爹的"], @[], nil];
    self.typeArray = @[@(1), @(2), @(3)];
    self.item = [[SZQuestionItem alloc] initWithTitleArray:self.titleArray andOptionArray:self.optionArray andResultArray:nil andQuestonTypes:self.typeArray];
    
    
    // 左上
    SZConfigure *configure1 = [[SZConfigure alloc] init];
    configure1.titleFont = 13;
    configure1.optionFont = 12;
    configure1.oneLineHeight = 35;
    configure1.buttonSize = 22;
    SZQuestionCheckBox *checkBox1 = [[SZQuestionCheckBox alloc] initWithItem:self.item andConfigure:configure1];
    [self addChildViewController:checkBox1];
    checkBox1.view.frame = CGRectMake(0, 0, self.view.center.x, self.view.center.y);
    [self.view addSubview:checkBox1.view];
    
    // 右上
    SZConfigure *configure2 = [[SZConfigure alloc] init];
    configure2.titleFont = 13;
    configure2.optionFont = 12;
    configure2.oneLineHeight = 35;
    configure2.buttonSize = 22;
    configure2.backColor = [UIColor redColor];
    SZQuestionCheckBox *checkBox2 = [[SZQuestionCheckBox alloc] initWithItem:self.item andConfigure:configure2];
    [self addChildViewController:checkBox2];
    checkBox2.view.frame = CGRectMake(self.view.center.x, 64, self.view.center.x, self.view.center.y - 64);
    [self.view addSubview:checkBox2.view];
    
    // 左下
    SZConfigure *configure3 = [[SZConfigure alloc] init];
    configure3.titleFont = 13;
    configure3.optionFont = 12;
    configure3.oneLineHeight = 35;
    configure3.buttonSize = 22;
    configure3.checkedImage = @"dx_h@2x";
    configure3.unCheckedImage = @"dx@2x";
    configure3.backColor = [UIColor orangeColor];
    SZQuestionCheckBox *checkBox3 = [[SZQuestionCheckBox alloc] initWithItem:self.item andConfigure:configure3];
    checkBox3.tableView.bounces = NO;
    checkBox3.tableView.showsVerticalScrollIndicator = NO;
    [self addChildViewController:checkBox3];
    checkBox3.view.frame = CGRectMake(0, self.view.center.y, self.view.center.x, self.view.center.y);
    [self.view addSubview:checkBox3.view];
    
    // 左下
    SZConfigure *configure4 = [[SZConfigure alloc] init];
    configure4.titleFont = 13;
    configure4.optionFont = 12;
    configure4.oneLineHeight = 35;
    configure4.buttonSize = 22;
    configure4.titleTextColor = [UIColor redColor];
    configure4.optionTextColor = [UIColor orangeColor];
    configure4.multipleCheckedImage = @"dx_h@2x";
    configure4.multipleUncheckedImage = @"dx@2x";
    configure4.answerFrameUseTextView = YES;
    SZQuestionCheckBox *checkBox4 = [[SZQuestionCheckBox alloc] initWithItem:self.item andConfigure:configure4];
    checkBox4.tableView.bounces = NO;
    checkBox4.tableView.showsVerticalScrollIndicator = NO;
    [self addChildViewController:checkBox4];
    checkBox4.view.frame = CGRectMake(self.view.center.x, self.view.center.y, self.view.center.x, self.view.center.y);
    [self.view addSubview:checkBox4.view];
}



@end
