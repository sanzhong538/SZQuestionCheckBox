//
//  SZQuestionItem.m
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/4/28.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "SZQuestionItem.h"

@interface SZQuestionItem ()

@property (nonatomic, strong) NSArray *questionArray;

@end

@implementation SZQuestionItem

- (instancetype)initWithTitleArray:(NSArray *)titleArray andOptionArray:(NSArray *)optionArray  andQuestonType:(SZQuestionItemType)type {
    
    NSArray *typeArray = [self creatTypeArray:titleArray type:type];
    return [self initWithTitleArray:titleArray
                     andOptionArray:optionArray
                    andQuestonTypes:typeArray];
}

- (instancetype)initWithTitleArray:(NSArray *)titleArray andOptionArray:(NSArray *)optionArray andResultArray:(NSArray *)resultArray andQuestonType:(SZQuestionItemType)type {
    
    NSArray *typeArray = [self creatTypeArray:titleArray type:type];
    return [self initWithTitleArray:titleArray
                     andOptionArray:optionArray
                     andResultArray:resultArray
                    andQuestonTypes:typeArray];
}

- (instancetype)initWithTitleArray:(NSArray *)titleArray andOptionArray:(NSArray *)optionArray  andQuestonTypes:(NSArray *)typeArray {
    
    return [self initWithTitleArray:titleArray
                     andOptionArray:optionArray
                     andResultArray:nil
                    andQuestonTypes:typeArray];
}

- (instancetype)initWithTitleArray:(NSArray *)titleArray andOptionArray:(NSArray *)optionArray andResultArray:(NSArray *)resultArray andQuestonTypes:(NSArray *)typeArray {
    
    if (self = [super init]) {
        
        self.questionArray = [self creatItemWithTitleArray:titleArray
                                            andOptionArray:optionArray
                                         andandResultArray:resultArray
                                           andQuestonTypes:typeArray];
    }
    return self;
}

- (NSArray *)creatTypeArray:(NSArray *)array type:(SZQuestionItemType)type{
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i < array.count; i++) {
        [arrayM addObject:@(type)];
    }
    return arrayM.copy;
}

- (NSArray *)creatItemWithTitleArray:(NSArray *)titleArray andOptionArray:(NSArray *)optionArray andandResultArray:(NSArray *)resultArray andQuestonTypes:(NSArray *)typeArray {
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:titleArray.count];
    
    for (int i = 0; i < titleArray.count; i++) {

        SZQuestionItemType type = [typeArray[i] intValue];
        if (type == SZQuestionOpenQuestion) {
            
            NSString *answerString = resultArray == nil ? @"" : resultArray[i];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:titleArray[i], @"title", answerString, @"marked", typeArray[i], @"type", nil];;
            [arrayM addObject:dict];
        }
        else {
            
            NSArray *answerArray = resultArray == nil ? [self createSelectArray:optionArray[i]] : resultArray[i];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:titleArray[i], @"title", optionArray[i], @"option", answerArray, @"marked", typeArray[i], @"type", nil];
            [arrayM addObject:dict];
        }
    }
    return arrayM.copy;
}

- (NSArray *)createSelectArray:(NSArray *)array {
    
    NSInteger count = [array count];
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0 ; i < count; i++) {
        [tempArray addObject:@(NO)];
    }
    return tempArray.copy;
}

- (NSArray *)ItemQuestionArray {
    
    return self.questionArray;
}

/**
 *  计算高度
 */
+ (CGFloat)heightForString:(NSString*)string width:(CGFloat)width fontSize:(CGFloat)fontSize oneLineHeight:(CGFloat)oneLineHeight{
    
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width - 16, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil];
    
    return rect.size.height > oneLineHeight ? rect.size.height : oneLineHeight;
}

@end
