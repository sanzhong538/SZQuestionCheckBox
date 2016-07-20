//
//  SZQuestionCheckBox.m
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/4/27.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "SZQuestionCheckBox.h"
#import "SZQuestionCell.h"
#import "SZQuestionOptionCell.h"

@interface SZQuestionCheckBox ()

@property (nonatomic, assign) CGFloat titleWidth;
@property (nonatomic, assign) CGFloat OptionWidth;
@property (nonatomic, assign) BOOL complete;
@property (nonatomic, strong) NSArray *tempArray;
@property (nonatomic, strong) NSMutableArray *arrayM;
@property (nonatomic, strong) SZConfigure *configure;
@property (nonatomic, assign) QuestionCheckBoxType chekBoxType;

@end

@implementation SZQuestionCheckBox

- (instancetype)initWithItem:(SZQuestionItem *)questionItem {
    
    SZConfigure *configure = [[SZConfigure alloc] init];
    return [self initWithItem:questionItem andConfigure:configure];
}

- (instancetype)initWithItem:(SZQuestionItem *)questionItem andConfigure:(SZConfigure *)configure {
    
    return [self initWithItem:questionItem andCheckBoxType:QuestionCheckBoxWithoutHeader andConfigure:configure];
}

- (instancetype)initWithItem:(SZQuestionItem *)questionItem andCheckBoxType:(QuestionCheckBoxType)checkBoxType {
    
    SZConfigure *configure = [[SZConfigure alloc] init];
    return [self initWithItem:questionItem andCheckBoxType:checkBoxType andConfigure:configure];
}


- (instancetype)initWithItem:(SZQuestionItem *)questionItem andCheckBoxType:(QuestionCheckBoxType)checkBoxType andConfigure:(SZConfigure *)configure {
    
    self = [super init];
    
    if (self) {
        self.sourceArray = questionItem.ItemQuestionArray;
        if (configure != nil) self.configure = configure;
        self.chekBoxType = checkBoxType;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.canEdit = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.titleWidth = self.view.frame.size.width - self.configure.titleSideMargin * 2;
    self.OptionWidth = self.view.frame.size.width - self.configure.optionSideMargin * 2 - self.configure.buttonSize - 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isComplete {
    
    [self getResult];
    return self.complete;
}

- (NSArray *)resultArray {
    
    [self getResult];
    return self.tempArray;
}

- (void)getResult {
    
    [self.view endEditing:YES];
    BOOL complete          = true;
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in self.sourceArray) {
        
        if ([dict[@"type"] integerValue] == SZQuestionOpenQuestion) {
            NSString *str = dict[@"marked"];
            complete      = (str.length > 0) && complete;
            [arrayM addObject:str.length ? str : @""];
        }
        else {
            NSArray *array = dict[@"marked"];
            complete       = ([array containsObject:@"YES"] || [array containsObject:@"yes"] || [array containsObject:@(1)] || [array containsObject:@"1"]) && complete;
            [arrayM addObject:array];
        }
    }
    self.complete   = complete;
    self.tempArray  = arrayM.copy;
}

- (void)setCanEdit:(BOOL)canEdit {
    
    _canEdit = canEdit;
    [self.tableView reloadData];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}

#pragma mark - UITableViewdatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.chekBoxType == QuestionCheckBoxWithHeader ? self.sourceArray.count : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (self.chekBoxType == QuestionCheckBoxWithHeader) {
        NSDictionary *dict = self.sourceArray[section];
        if ([dict[@"type"] intValue] == SZQuestionOpenQuestion) {
            return 1;
        }
        else {
            NSArray *optionArray = dict[@"option"];
            return optionArray.count;
        }
    }
    else {
        return self.sourceArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.chekBoxType == QuestionCheckBoxWithHeader) {
        NSDictionary *dict = self.sourceArray[indexPath.section];
        SZQuestionOptionCell *cell = [[SZQuestionOptionCell alloc]
                                      initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"questionOptionCellIdentifier"
                                      andDict:dict
                                      andIndexPath:indexPath
                                      andWidth:self.view.frame.size.width
                                      andConfigure:self.configure];
        __weak typeof(self) weakSelf = self;
        cell.selectOptionButtonBack = ^(NSIndexPath *indexPath, NSDictionary *dict) {
            [weakSelf.arrayM replaceObjectAtIndex:indexPath.section withObject:dict];
            weakSelf.sourceArray = weakSelf.arrayM.copy;
            NSIndexSet *set = [NSIndexSet indexSetWithIndex:indexPath.section];
            [weakSelf.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = self.canEdit;
        return cell;
    }
    else {
        NSDictionary *dict = self.sourceArray[indexPath.row];
        SZQuestionCell *cell = [[SZQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:@"questionCellIdentifier"
                                                             andDict:dict
                                                      andQuestionNum:indexPath.row + 1
                                                            andWidth:self.view.frame.size.width
                                                        andConfigure:self.configure];
        __weak typeof(self) weakSelf = self;
        cell.selectOptionBack = ^(NSInteger index, NSDictionary *dict, BOOL refresh) {
            [weakSelf.arrayM replaceObjectAtIndex:index withObject:dict];
            weakSelf.sourceArray = weakSelf.arrayM.copy;
            if (refresh) {
                NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
                [weakSelf.tableView reloadRowsAtIndexPaths:@[path] withRowAnimation:UITableViewRowAnimationNone];
            }
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = self.canEdit;
        return cell;
    }
}

#pragma mark - UITableViewdelegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (self.chekBoxType == QuestionCheckBoxWithHeader) {
        NSDictionary *dict = self.sourceArray[section];
        NSString *title = self.configure.automaticAddLineNumber ? [NSString stringWithFormat:@"%zd、%@", section + 1, dict[@"title"]] : dict[@"title"];
        CGFloat title_height = [SZQuestionItem heightForString:title
                                                         width:self.titleWidth
                                                      fontSize:self.configure.titleFont
                                                 oneLineHeight:self.configure.oneLineHeight];
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor whiteColor];
        UILabel *lbl =({
            lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.configure.titleSideMargin, 0, self.titleWidth, title_height)];
            lbl.font = [UIFont systemFontOfSize:self.configure.titleFont];
            lbl.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            lbl.numberOfLines = 0;
            lbl.text = title;
            lbl;
        });
        [v addSubview:lbl];
        return v;
    }
    else {
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.chekBoxType == QuestionCheckBoxWithHeader) {
        NSDictionary *dict = self.sourceArray[section];
        CGFloat title_height = [SZQuestionItem heightForString:dict[@"title"]
                                                         width:self.titleWidth
                                                      fontSize:self.configure.titleFont
                                                 oneLineHeight:self.configure.oneLineHeight];
        return title_height;
    }
    else {
        return 0;
    }
}

/**
 *  返回各个Cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.chekBoxType == QuestionCheckBoxWithHeader) {
        
        NSDictionary *dict = self.sourceArray[indexPath.section];
        if ([dict[@"type"] intValue] == SZQuestionOpenQuestion) {
            
            return self.configure.oneLineHeight;
        }
        else {
            
            NSArray *optionArray = dict[@"option"];
            NSString *optionString = [NSString stringWithFormat:@"M、%@", optionArray[indexPath.row]];
            CGFloat option_height = [SZQuestionItem heightForString:optionString width:self.OptionWidth fontSize:self.configure.optionFont oneLineHeight:self.configure.oneLineHeight];
            return option_height;
        }
    }
    else {
        
        CGFloat topDistance = (indexPath.row == 0 ? self.configure.topDistance : 0);
        NSDictionary *dict = self.sourceArray[indexPath.row];
        
        if ([dict[@"type"] intValue] == SZQuestionOpenQuestion) {
            
            CGFloat title_height = [SZQuestionItem heightForString:dict[@"title"]
                                                             width:self.titleWidth
                                                          fontSize:self.configure.titleFont
                                                     oneLineHeight:self.configure.oneLineHeight];
            if (self.configure.answerFrameFixedHeight && self.configure.answerFrameUseTextView == YES) {
                return title_height + self.configure.answerFrameFixedHeight + 10 + topDistance;
            }
            if ([dict[@"marked"] length] > 0) {
                CGFloat answer_width = self.view.frame.size.width - self.configure.optionSideMargin * 2;
                CGFloat answer_height = [SZQuestionItem heightForString:dict[@"marked"] width:answer_width - 10 fontSize:self.configure.optionFont oneLineHeight:self.configure.oneLineHeight];
                if (self.configure.answerFrameLimitHeight && answer_height > self.configure.answerFrameLimitHeight && self.configure.answerFrameUseTextView == YES) {
                    return title_height + self.configure.answerFrameLimitHeight + 10 + topDistance;
                }
                return title_height + answer_height + 10 + topDistance;
            }
            return title_height + self.configure.oneLineHeight + topDistance;
        }
        else {
            
            CGFloat title_height = [SZQuestionItem heightForString:dict[@"title"]
                                                             width:self.titleWidth
                                                          fontSize:self.configure.titleFont
                                                     oneLineHeight:self.configure.oneLineHeight];
            CGFloat option_height = 0;
            for (NSString *str in dict[@"option"]) {
                NSString *optionString = [NSString stringWithFormat:@"M、%@", str];
                option_height += [SZQuestionItem heightForString:optionString width:self.OptionWidth fontSize:self.configure.optionFont oneLineHeight:self.configure.oneLineHeight];
            }
            return title_height + option_height + topDistance;
        }
    }
}

#pragma mark - 懒加载

- (NSMutableArray *)arrayM {
    
    if (_arrayM == nil) {
        _arrayM = [[NSMutableArray alloc] initWithArray:self.sourceArray];
    }
    return _arrayM;
}

@end
