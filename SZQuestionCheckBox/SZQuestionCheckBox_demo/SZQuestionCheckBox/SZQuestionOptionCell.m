//
//  SZQuestionOptionCell.m
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/6/16.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "SZQuestionOptionCell.h"
#import "SZQuestionItem.h"
#import "SZConfigure.h"

@interface SZQuestionOptionCell ()<UITextFieldDelegate>

@property (nonatomic, strong) NSDictionary          *contentDict;
@property (nonatomic, strong) NSArray               *letterArray;
@property (nonatomic, assign) SZQuestionItemType    type;
@property (nonatomic, strong) SZConfigure           *configure;

@end

@implementation SZQuestionOptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                      andDict:(NSDictionary *)contentDict
                 andIndexPath:(NSIndexPath *)indexPath
                     andWidth:(CGFloat)width
                 andConfigure:(SZConfigure *)configure {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.configure      =   configure;
        self.contentDict    =   contentDict;
        self.indexPath      =   indexPath;
        self.type           =   [contentDict[@"type"] integerValue];
        [self setupLayoutWithDict:contentDict andWidth:width];
    }
    return self;
}

- (void)setupLayoutWithDict:(NSDictionary *)dict andWidth:(CGFloat)width{
    
    self.backgroundColor = self.configure.backColor;
    if ([dict[@"type"] intValue] == SZQuestionOpenQuestion) {
        UITextField *textField = ({
            textField = [[UITextField alloc] initWithFrame:CGRectMake(self.configure.optionSideMargin, 5, width - self.configure.optionSideMargin * 2, self.configure.oneLineHeight - 10)];
            textField.font = [UIFont systemFontOfSize:self.configure.optionFont];
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.textColor = self.configure.optionTextColor;
            textField.delegate = self;
            textField;
        });
        if (dict[@"marked"] != nil) {
            textField.text = dict[@"marked"];
        }
        [self addSubview: textField];
    }
    else {
        NSArray *optionArray = dict[@"option"];
        NSArray *selectArray = dict[@"marked"];
        CGFloat optionWidth = width - self.configure.optionSideMargin * 2 - self.configure.buttonSize - 5;
        CGFloat option_height = [SZQuestionItem heightForString:optionArray[self.indexPath.row]
                                                          width:optionWidth
                                                       fontSize:self.configure.optionFont
                                                  oneLineHeight:self.configure.oneLineHeight];
        UILabel *lbl = ({
            lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.configure.optionSideMargin + self.configure.buttonSize + 5, 0, optionWidth, option_height)];
            lbl.numberOfLines = 0;
            lbl.textColor = self.configure.optionTextColor;
            lbl.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
            lbl.font = [UIFont systemFontOfSize:self.configure.optionFont];
            lbl.text = [NSString stringWithFormat:@"%@、%@", self.letterArray[self.indexPath.row], optionArray[self.indexPath.row]];
            lbl;
        });
        [self addSubview:lbl];
        
        UIButton *btn = ({
            btn = [[UIButton alloc] initWithFrame:CGRectMake(self.configure.optionSideMargin, ABS(self.configure.oneLineHeight - self.configure.buttonSize) * 0.5, self.configure.buttonSize, self.configure.buttonSize)];
            [btn setImage:[UIImage imageNamed:self.configure.unCheckedImage] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:self.configure.checkedImage] forState:UIControlStateSelected];
            [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            btn.selected = selectArray.count > 0 ? [selectArray[self.indexPath.row] boolValue] : NO;
            btn;
        });
        [self addSubview:btn];
    }
}

- (void)clickButton:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] initWithDictionary:self.contentDict];
    if (self.type == SZQuestionSingleChoice) {
        
        NSInteger count = [self.contentDict[@"option"] count];
        NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:count];
        for (NSInteger i = 0 ; i < count; i++) {
            if (i == self.indexPath.row) {
                [tempArray addObject:@(sender.selected)];
            }
            else {
                [tempArray addObject:@(NO)];
            }
        }
        dictM[@"marked"] = tempArray.copy;
    }
    else {
        NSArray *selectArray = self.contentDict[@"marked"];
        NSMutableArray *tempArray = selectArray.mutableCopy;
        [tempArray replaceObjectAtIndex:self.indexPath.row withObject:@(sender.selected)];
        dictM[@"marked"] = tempArray.copy;
    }
    self.selectOptionButtonBack(self.indexPath, dictM.copy);
}

#pragma mark -  UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] initWithDictionary:self.contentDict];
    dictM[@"marked"] = textField.text;
    if (self.selectOptionButtonBack) {
        self.selectOptionButtonBack(self.indexPath, dictM.copy);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    for (UIView *v in [UIApplication sharedApplication].keyWindow.subviews) {
        [v endEditing:YES];
    }
}

- (NSArray *)letterArray {
    
    if (_letterArray == nil) {
        _letterArray = @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L", @"M", @"N", @"O", @"P", @"Q", @"R", @"", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"];
    }
    return _letterArray;
}

@end
