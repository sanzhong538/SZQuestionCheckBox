//
//  SZQuestionCell.m
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/4/28.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "SZQuestionCell.h"
#import "SZConfigure.h"
#import "SZQuestionItem.h"

@interface SZQuestionCell ()<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) NSDictionary          *contentDict;
@property (nonatomic, strong) NSArray               *letterArray;
@property (nonatomic, strong) NSArray               *buttonArray;
@property (nonatomic, assign) NSInteger             questionNum;
@property (nonatomic, assign) SZQuestionItemType    type;
@property (nonatomic, strong) SZConfigure           *configure;
@property (nonatomic, assign) CGFloat               current_height;

@end

@implementation SZQuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                      andDict:(NSDictionary *)contentDict
               andQuestionNum:(NSInteger)questionNum
                     andWidth:(CGFloat)width
                 andConfigure:(SZConfigure *)configure {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.configure      =   configure;
        self.contentDict    =   contentDict;
        self.questionNum    =   questionNum;
        self.type           =   [contentDict[@"type"] integerValue];
        [self setupLayoutWithDict:contentDict andWidth:width];
    }
    return self;
}

- (void)setupLayoutWithDict:(NSDictionary *)dict andWidth:(CGFloat)width{
    
    if (self.configure.cellBackgroundImage) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
        imageView.image = [UIImage imageNamed:self.configure.cellBackgroundImage];
        self.backgroundView = imageView;
    }
    CGFloat titleWidth = width - self.configure.titleSideMargin * 2;
    CGFloat optionWidth = width - self.configure.optionSideMargin * 2 - self.configure.buttonSize - 5;
    CGFloat fixedHeight = (self.configure.answerFrameFixedHeight && self.configure.answerFrameUseTextView == YES) ? self.configure.answerFrameFixedHeight : self.configure.oneLineHeight;
    self.configure.topDistance = self.questionNum == 1 ? self.configure.topDistance : 5;
    self.backgroundColor = self.configure.backColor;
    NSString *title = self.configure.automaticAddLineNumber ? [NSString stringWithFormat:@"%zd、%@", self.questionNum, dict[@"title"]] : dict[@"title"];
    // 标题
    CGFloat height = [SZQuestionItem heightForString:title
                                               width:titleWidth
                                            fontSize:self.configure.titleFont
                                       oneLineHeight:self.configure.oneLineHeight];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.configure.titleSideMargin, self.configure.topDistance, titleWidth, height)];
    titleLabel.textColor = self.configure.titleTextColor;
    titleLabel.font = [UIFont systemFontOfSize:self.configure.titleFont];
    titleLabel.text = title;
    titleLabel.numberOfLines = 0;
    [self addSubview:titleLabel];
    
    // 选项或回答框
    if (self.type == SZQuestionOpenQuestion) {
        
        if (self.configure.answerFrameUseTextView == NO) {
            
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(self.configure.optionSideMargin, height + self.configure.topDistance, width - self.configure.optionSideMargin * 2, self.configure.oneLineHeight - 5)];
            textField.font = [UIFont systemFontOfSize:self.configure.optionFont];
            textField.borderStyle = UITextBorderStyleRoundedRect;
            textField.textColor = self.configure.optionTextColor;
            textField.delegate = self;
            if (dict[@"marked"] != nil) {
                textField.text = dict[@"marked"];
            }
            [self addSubview: textField];
        }
        else {
            
            UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(self.configure.optionSideMargin, height + self.configure.topDistance, width - self.configure.optionSideMargin * 2, fixedHeight - 5)];
            textView.font = [UIFont systemFontOfSize:self.configure.optionFont];
            textView.textColor = self.configure.optionTextColor;
            textView.showsVerticalScrollIndicator = NO;
            textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
            textView.layer.borderWidth = 1;
            textView.layer.cornerRadius = 5;
            textView.layer.masksToBounds = YES;
            textView.bounces = NO;
            textView.delegate = self;
            if (dict[@"marked"] != nil) {
                textView.text = dict[@"marked"];
            }
            [self addSubview:textView];
        }
    }
    else {
        
        UILabel *currentLabel;
        NSMutableArray *tempArray = [NSMutableArray array];
        NSArray *optionArray = dict[@"option"];
        NSArray *selectArray = dict[@"marked"];
        BOOL isSingleChoice = (self.type == SZQuestionSingleChoice);
        for (int i = 0; i < optionArray.count; i++) {
            
            CGFloat option_height = [SZQuestionItem heightForString:optionArray[i]
                                                              width:optionWidth
                                                           fontSize:self.configure.optionFont
                                                      oneLineHeight:self.configure.oneLineHeight];
            if (currentLabel == nil) {
                UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.configure.optionSideMargin + self.configure.buttonSize + 5, height + self.configure.topDistance, optionWidth, option_height)];
                lbl.numberOfLines = 0;
                lbl.textColor = self.configure.optionTextColor;
                lbl.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
                lbl.font = [UIFont systemFontOfSize:self.configure.optionFont];
                lbl.text = [NSString stringWithFormat:@"%@、%@", self.letterArray[i], optionArray[i]];
                [self addSubview:lbl];
                
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.configure.optionSideMargin, height + self.configure.topDistance + ABS(self.configure.oneLineHeight - self.configure.buttonSize) * 0.5, self.configure.buttonSize, self.configure.buttonSize)];
                [btn setImage:[UIImage imageNamed:(isSingleChoice ? self.configure.unCheckedImage : self.configure.multipleUncheckedImage)] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:(isSingleChoice ? self.configure.checkedImage : self.configure.multipleCheckedImage)] forState:UIControlStateSelected];
                [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
                btn.selected = selectArray.count > 0 ? [selectArray[i] boolValue] : NO;
                [self addSubview:btn];
                [tempArray addObject:btn];
            
                currentLabel = lbl;
            }
            else {
                UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.configure.optionSideMargin + self.configure.buttonSize + 5, CGRectGetMaxY(currentLabel.frame), optionWidth, option_height)];
                lbl.numberOfLines = 0;
                lbl.textColor = self.configure.optionTextColor;
                lbl.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
                lbl.font = [UIFont systemFontOfSize:self.configure.optionFont];
                lbl.text = [NSString stringWithFormat:@"%@、%@", self.letterArray[i], optionArray[i]];
                [self addSubview:lbl];
                
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.configure.optionSideMargin, CGRectGetMaxY(currentLabel.frame) + ABS(self.configure.oneLineHeight - self.configure.buttonSize) * 0.5, self.configure.buttonSize, self.configure.buttonSize)];
                [btn setImage:[UIImage imageNamed:(isSingleChoice ? self.configure.unCheckedImage : self.configure.multipleUncheckedImage)] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:(isSingleChoice ? self.configure.checkedImage : self.configure.multipleCheckedImage)] forState:UIControlStateSelected];
                [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
                btn.selected = selectArray.count > 0 ? [selectArray[i] boolValue] : NO;
                [self addSubview:btn];
                [tempArray addObject:btn];
                
                currentLabel = lbl;
            }
        }
        self.buttonArray = tempArray.copy;
    }
}

#pragma mark -  UITextViewDelegate

- (void)textViewDidChangeSelection:(UITextView *)textView {
    
    BOOL refresh = NO;
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] initWithDictionary:self.contentDict];
    dictM[@"marked"] = textView.text;
    if (self.configure.answerFrameUseTextView == YES && self.configure.answerFrameFixedHeight) {
        if (self.selectOptionBack) {
            self.selectOptionBack(self.questionNum - 1, dictM.copy, refresh);
        }
        return;
    }
    CGFloat h = [SZQuestionItem heightForString:textView.text width:textView.frame.size.width - 10 fontSize:self.configure.optionFont oneLineHeight:self.configure.oneLineHeight];
    if (self.current_height > 0 && self.current_height != h) {
        refresh = YES;
    }
    self.current_height = h;
    CGRect rect = textView.frame;
    if (self.configure.answerFrameLimitHeight && h > self.configure.answerFrameLimitHeight) {
        rect.size.height = self.configure.answerFrameLimitHeight;
    }
    else {
        rect.size.height = h;
    }
    textView.frame = rect;
    
    if (textView.isFirstResponder) {
        dispatch_async(dispatch_get_main_queue(), ^{
            @try
            {
                if (self.selectOptionBack) {
                    self.selectOptionBack(self.questionNum - 1, dictM.copy, refresh);
                }
                [textView becomeFirstResponder];
                
            }@catch (NSException * e) {
                
                [textView becomeFirstResponder];
            }
        });
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    if (textView.text.length > 0) {
        self.current_height = [SZQuestionItem heightForString:textView.text width:textView.frame.size.width - 10 fontSize:self.configure.optionFont oneLineHeight:self.configure.oneLineHeight];
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    
    self.current_height = 0;
}

#pragma mark -  UITextFieldDelegate
/*
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] initWithDictionary:self.contentDict];
    NSString *txtString = textField.text;
    dictM[@"marked"] = ([string isEqualToString:@""] && txtString.length > 0) ? [txtString substringToIndex:txtString.length - 1] : [txtString stringByAppendingString:string];
    if (self.selectOptionBack) {
        self.selectOptionBack(self.questionNum - 1, dictM.copy, NO);
    }
    return YES;
}
 */

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] initWithDictionary:self.contentDict];
    dictM[@"marked"] = textField.text;
    if (self.selectOptionBack) {
        self.selectOptionBack(self.questionNum - 1, dictM.copy, NO);
    }
    return YES;
}

- (void)clickButton:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] initWithDictionary:self.contentDict];
    if (self.type == SZQuestionSingleChoice) {
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (UIButton *btn in self.buttonArray) {
            
            if (btn != sender) {
                
                btn.selected = NO;
            }
            [tempArray addObject:@(btn.selected)];
        }
        dictM[@"marked"] = tempArray.copy;
    }
    else {
        
        NSMutableArray *tempArray = [NSMutableArray array];
        for (UIButton *btn in self.buttonArray) {

            [tempArray addObject:@(btn.selected)];
        }
        dictM[@"marked"] = tempArray.copy;
    }
    self.selectOptionBack(self.questionNum - 1, dictM.copy, NO);
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
