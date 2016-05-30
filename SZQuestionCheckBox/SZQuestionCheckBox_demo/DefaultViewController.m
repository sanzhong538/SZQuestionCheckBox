//
//  DefaultViewController.m
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/5/26.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "DefaultViewController.h"
#import "SZQuestionCheckBox.h"

@interface DefaultViewController ()

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *optionArray;

@property (nonatomic, strong) NSArray *typeArray;

@property (nonatomic, strong) SZQuestionCheckBox *questionBox;

@property (nonatomic, strong) NSArray *resultArray;

@end

@implementation DefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = [NSArray arrayWithObjects:@"第一题 你感觉这个Demo如何，能否帮助到你？", @"第二题 你感觉程序员是一群什么样的人？", @"第三题 作为程序员你最想对程序说的一句话是", nil];
    self.optionArray = [NSArray arrayWithObjects:@[@"很好，正是我所需要的", @"不错，值得学习借鉴", @"一般般而已，没什么好看的", @"太Low,不忍直视", @"不知所云"], @[@"最帅的", @"有钱途的", @"富有创造力", @"有梦想的", @"费脑的", @"坑爹的"], @[], nil];
    self.typeArray = @[@(1), @(2), @(3)];
    
}

- (IBAction)answerQuestion:(UIButton *)sender {
    
    SZQuestionItem *item = [[SZQuestionItem alloc] initWithTitleArray:self.titleArray andOptionArray:self.optionArray andResultArray: self.resultArray andQuestonTypes:self.typeArray];
    
    self.questionBox = [[SZQuestionCheckBox alloc] initWithItem:item];
    
    [self.navigationController pushViewController:self.questionBox animated:YES];
}

- (IBAction)showResult:(UIButton *)sender {
    
    self.resultArray = self.questionBox.resultArray;
    
    NSLog(@"%@", self.questionBox.isComplete ? @"做完了" : @"未做完");
    
    NSLog(@"%@", self.questionBox.resultArray);
}

- (IBAction)clickWithoutResultBtn:(UIButton *)sender {
    
    SZQuestionItem *item = [[SZQuestionItem alloc] initWithTitleArray:self.titleArray andOptionArray:self.optionArray andQuestonTypes:self.typeArray];
    
    self.questionBox = [[SZQuestionCheckBox alloc] initWithItem:item];
    
    [self.navigationController pushViewController:self.questionBox animated:YES];
}

@end
