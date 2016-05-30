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

/**
 *  构造方法 -- 没有有结果数组，单一题型
 *
 *  @param titleArray  结果数组
 *  @param optionArray 选项数组
 *  @param type        类型
 *
 *  @return
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArray andOptionArray:(NSArray *)optionArray  andQuestonType:(SZQuestionItemType)type;

/**
 *  构造方法 -- 有结果数组，单一题型
 *
 *  @param titleArray  结果数组
 *  @param optionArray 选项数组
 *  @param resultArray 结果数组
 *  @param type        类型
 *
 *  @return
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArray andOptionArray:(NSArray *)optionArray andResultArray:(NSArray *)resultArray andQuestonType:(SZQuestionItemType)type;

/**
 *  构造方法 -- 没有结果数组，多种题型
 *
 *  @param titleArray  标题数组
 *  @param optionArray 选项数组
 *  @param typeArray   题型数组
 *
 *  @return
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArray andOptionArray:(NSArray *)optionArray  andQuestonTypes:(NSArray *)typeArray;

/**
 *  构造方法 -- 有结果数组，多种题型
 *
 *  @param titleArray  标题数组
 *  @param optionArray 选项数组
 *  @param selectArray 结果数组
 *  @param typeArray   题型数组
 *
 *  @return
 */
- (instancetype)initWithTitleArray:(NSArray *)titleArray andOptionArray:(NSArray *)optionArray andResultArray:(NSArray *)resultArray andQuestonTypes:(NSArray *)typeArray;

/**
 *  计算高度
 */
+ (CGFloat)heightForString:(NSString*)string width:(CGFloat)width fontSize:(CGFloat)fontSize oneLineHeight:(CGFloat)oneLineHeight;

@end