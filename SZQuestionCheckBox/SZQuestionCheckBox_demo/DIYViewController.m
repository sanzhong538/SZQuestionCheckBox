//
//  DIYViewController.m
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/5/26.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "DIYViewController.h"
#import "SZQuestionCheckBox.h"

@interface DIYViewController ()

@property (nonatomic, strong) SZQuestionCheckBox *questionBox;

@property (nonatomic, strong) SZQuestionItem *item;

@property (nonatomic, strong) NSArray *titleArray;

@property (nonatomic, strong) NSArray *optionArray;

@property (nonatomic, strong) NSArray *typeArray;

@end

@implementation DIYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleArray = [NSArray arrayWithObjects:@"第一题 你感觉这个Demo如何，能否帮助到你？", @"第二题 你感觉程序员是一群什么样的人？", @"第三题 作为程序员你最想对程序说的一句话是", nil];
    self.optionArray = [NSArray arrayWithObjects:@[@"很好，正是我所需要的", @"不错，值得学习借鉴", @"一般般而已，没什么好看的", @"太Low,不忍直视", @"不知所云"], @[@"最帅的", @"有钱途的", @"富有创造力", @"有梦想的", @"费脑的", @"坑爹的"], @[], nil];
    self.typeArray = @[@(1), @(2), @(3)];
    self.item = [[SZQuestionItem alloc] initWithTitleArray:self.titleArray andOptionArray:self.optionArray andSelectArray:nil andQuestonType:self.typeArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickBtn1:(UIButton *)sender {
    
    SZConfigure *configure = [[SZConfigure alloc] init];
    configure.titleFont = 15;
    configure.optionFont = 13;
    configure.buttonSize = 20;
    configure.titleTextColor = [UIColor blueColor];
    configure.optionTextColor = [UIColor purpleColor];
    configure.oneLineHeight = 35;
    
    self.questionBox = [[SZQuestionCheckBox alloc] initWithItem:self.item andConfigure:configure];
    
    [self.navigationController pushViewController:self.questionBox animated:YES];
}


- (IBAction)clickBtn2:(UIButton *)sender {
    
    SZConfigure *configure = [[SZConfigure alloc] init];
    configure.checkedImage = @"dx_h@2x";
    configure.unCheckedImage = @"dx@2x";
    configure.optionTextColor = [UIColor lightGrayColor];
    self.questionBox = [[SZQuestionCheckBox alloc] initWithItem:self.item andConfigure:configure];
    [self.navigationController pushViewController:self.questionBox animated:YES];
    
}

- (IBAction)clickBtn3:(UIButton *)sender {
    
    SZConfigure *configure = [[SZConfigure alloc] init];
    configure.titleSideMargin = 40;
    configure.optionSideMargin = 50;
    configure.titleFont = 15;
    configure.optionFont = 13;
    configure.buttonSize = 20;
    configure.topDistance = 100;
    self.questionBox = [[SZQuestionCheckBox alloc] initWithItem:self.item andConfigure:configure];
    [self.navigationController pushViewController:self.questionBox animated:YES];
    
}

- (IBAction)clickBtn4:(UIButton *)sender {
    
}



@end
