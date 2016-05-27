//
//  SZQuestionItem.h
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/4/28.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SZQuestionItemType) {
    SZQuestionSingleChoice = 1,
    SZQuestionMultipleChoice,
    SZQuestionOpenQuestion,
};

@interface SZQuestionItem : NSObject

@property (nonatomic, strong, readonly) NSArray *ItemQuestionArray;

- (instancetype)initWithTitleArray:(NSArray *)titleArray andOptionArray:(NSArray *)optionArray andSelectArray:(NSArray *)selectArray andQuestonType:(NSArray *)typeArray;

/**
 *  计算高度
 */
+ (CGFloat)heightForString:(NSString*)string width:(CGFloat)width fontSize:(CGFloat)fontSize oneLineHeight:(CGFloat)oneLineHeight;

@end