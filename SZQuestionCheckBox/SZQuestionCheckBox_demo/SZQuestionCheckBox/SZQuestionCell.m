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

@interface SZQuestionCell ()<UITextFieldDelegate>

@property (nonatomic, strong) NSDictionary *contentDict;

@property (nonatomic, strong) NSArray *letterArray;

@property (nonatomic, strong) NSArray *buttonArray;

@property (nonatomic, assign) NSInteger questionNum;

@property (nonatomic, assign)  SZQuestionItemType type;

@property (nonatomic, strong) SZConfigure *configure;

// configure 属性

@property (nonatomic, assign) CGFloat titleFont;

@property (nonatomic, assign) CGFloat optionFont;

@property (nonatomic, strong) UIColor *backColor;

@property (nonatomic, strong) UIColor *titleTextColor;

@property (nonatomic, strong) UIColor *optionTextColor;

@property (nonatomic, assign) CGFloat oneLineHeight;

@property (nonatomic, assign) CGFloat topDistance;

@property (nonatomic, assign) CGFloat titleSideMargin;

@property (nonatomic, assign) CGFloat optionSideMargin;

@property (nonatomic, assign) CGFloat buttonSize;

@property (nonatomic, copy) NSString *checkedImage;

@property (nonatomic, copy) NSString *unCheckedImage;

@end

@implementation SZQuestionCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDict:(NSDictionary *)contentDict andQuestionNum:(NSInteger)questionNum andWidth:(CGFloat)width andConfigure:(SZConfigure *)configure {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.configure      = configure;
        self.contentDict    = contentDict;
        self.questionNum    = questionNum;
        self.type           = [contentDict[@"type"] integerValue];
        [self setupLayoutWithDict:contentDict andWidth:width];
    }
    return self;
}

- (void)setConfigure:(SZConfigure *)configure {
    
    _configure = configure;
    self.titleFont      = configure.titleFont ? configure.titleFont : 17;
    self.optionFont     = configure.optionFont ? configure.optionFont : 16;
    self.oneLineHeight  = configure.oneLineHeight ? configure.oneLineHeight : OPEN_OPTION_CELL_H;
    self.topDistance    = configure.topDistance ? configure.topDistance : 5;
    self.buttonSize     = configure.buttonSize ? configure.buttonSize : BUTTON_WIDTH;
    self.checkedImage   = configure.checkedImage ? configure.checkedImage : @"checked";
    self.unCheckedImage = configure.unCheckedImage ? configure.unCheckedImage : @"unchecked";
    self.backColor      = configure.backColor ? configure.backColor : [UIColor whiteColor];
    self.titleTextColor   = configure.titleTextColor ? configure.titleTextColor : [UIColor blackColor];
    self.optionSideMargin = configure.optionSideMargin  ? configure.optionSideMargin : OPTION_MARGIN;
    self.titleSideMargin  = configure.titleSideMargin ? configure.titleSideMargin : HEADER_MARGIN;
    self.optionTextColor  = configure.optionTextColor ? configure.optionTextColor : [UIColor blackColor];
}

- (void)setupLayoutWithDict:(NSDictionary *)dict andWidth:(CGFloat)width{
    
    CGFloat titleWidth = width - self.titleSideMargin * 2;
    CGFloat optionWidth = width - self.optionSideMargin * 2 - self.buttonSize - 5;
    self.topDistance = self.questionNum == 1 ? self.topDistance : 5;
    self.backgroundColor = self.backColor;
    // 标题
    CGFloat height = [SZQuestionItem heightForString:dict[@"title"] width:titleWidth fontSize:self.titleFont oneLineHeight:self.oneLineHeight];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleSideMargin, self.topDistance, titleWidth, height)];
    titleLabel.textColor = self.titleTextColor;
    titleLabel.font = [UIFont systemFontOfSize:self.titleFont];
    titleLabel.text = [NSString stringWithFormat:@"%zd、%@", self.questionNum, dict[@"title"]];
    titleLabel.numberOfLines = 0;
    [self addSubview:titleLabel];
    
    // 选项或回答框
    if ([dict[@"type"] intValue] == SZQuestionOpenQuestion) {
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(self.optionSideMargin, height + self.topDistance, width - self.optionSideMargin * 2, self.oneLineHeight - 10)];
        textField.font = [UIFont systemFontOfSize:self.optionFont];
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.textColor = self.optionTextColor;
        textField.delegate = self;
        if (dict[@"marked"] != nil) {
            textField.text = dict[@"marked"];
        }
        [self addSubview: textField];
    }
    else {
        
        UILabel *currentLabel;
        NSMutableArray *tempArray = [NSMutableArray array];
        NSArray *optionArray = dict[@"option"];
        NSArray *selectArray = dict[@"marked"];
        for (int i = 0; i < optionArray.count; i++) {
            
            CGFloat option_height = [SZQuestionItem heightForString:optionArray[i] width:optionWidth fontSize:self.optionFont oneLineHeight:self.oneLineHeight];
            if (currentLabel == nil) {
                UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.optionSideMargin + self.buttonSize + 5, height + self.topDistance, optionWidth, option_height)];
                lbl.numberOfLines = 0;
                lbl.textColor = self.optionTextColor;
                lbl.font = [UIFont systemFontOfSize:self.optionFont];
                lbl.text = [NSString stringWithFormat:@"%@、%@", self.letterArray[i], optionArray[i]];
                [self addSubview:lbl];
                
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.optionSideMargin, height + self.topDistance + 5, self.buttonSize, self.buttonSize)];
                [btn setImage:[UIImage imageNamed:self.unCheckedImage] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:self.checkedImage] forState:UIControlStateSelected];
                [btn addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
                btn.selected = selectArray.count > 0 ? [selectArray[i] boolValue] : NO;
                [self addSubview:btn];
                [tempArray addObject:btn];
            
                currentLabel = lbl;
            }
            else {
                UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(self.optionSideMargin + self.buttonSize + 5, CGRectGetMaxY(currentLabel.frame), optionWidth, option_height)];
                lbl.numberOfLines = 0;
                lbl.textColor = self.optionTextColor;
                lbl.font = [UIFont systemFontOfSize:self.optionFont];
                lbl.text = [NSString stringWithFormat:@"%@、%@", self.letterArray[i], optionArray[i]];
                [self addSubview:lbl];
                
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(self.optionSideMargin, CGRectGetMaxY(currentLabel.frame) + 5, self.buttonSize, self.buttonSize)];
                [btn setImage:[UIImage imageNamed:self.unCheckedImage] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:self.checkedImage] forState:UIControlStateSelected];
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

#pragma mark -  UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSMutableDictionary *dictM = [[NSMutableDictionary alloc] initWithDictionary:self.contentDict];
    dictM[@"marked"] = textField.text;
    self.selectOptionBack(self.questionNum - 1, dictM.copy);
    
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
    self.selectOptionBack(self.questionNum - 1, dictM.copy);
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
