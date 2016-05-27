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

- (instancetype)initWithTitleArray:(NSArray *)titleArray andOptionArray:(NSArray *)optionArray andSelectArray:(NSArray *)selectArray andQuestonType:(NSArray *)typeArray {
    
    if (self = [super init]) {
        
        self.questionArray = [self creatItemWithTitleArray:titleArray andOptionArray:optionArray andSelectArray:selectArray andQuestonType:typeArray];
    }
    return self;
}

- (NSArray *)ItemQuestionArray {
    
    return self.questionArray;
}


- (NSArray *)creatItemWithTitleArray:(NSArray *)titleArray andOptionArray:(NSArray *)optionArray andSelectArray:(NSArray *)selectArray andQuestonType:(NSArray *)typeArray {
    
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:titleArray.count];
    
    for (int i = 0; i < titleArray.count; i++) {

        SZQuestionItemType type = [typeArray[i] intValue];

        if (type == SZQuestionOpenQuestion) {
            
            NSDictionary *dict = nil;
            if (selectArray == nil) {
                
                dict = [NSDictionary dictionaryWithObjectsAndKeys:titleArray[i], @"title", @"", @"marked",typeArray[i], @"type", nil];
            }
            else {
                
                dict = [NSDictionary dictionaryWithObjectsAndKeys:titleArray[i], @"title", selectArray[i], @"marked", typeArray[i], @"type", nil];
            }
            [arrayM addObject:dict];
        }
        else {
            
            NSDictionary *dict = nil;
            if (selectArray == nil) {
                
                NSInteger count = [optionArray[i] count];
                NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:count];
                for (int i = 0 ; i < count; i++) {
                    [tempArray addObject:@(NO)];
                }
                dict = [NSDictionary dictionaryWithObjectsAndKeys:titleArray[i], @"title", optionArray[i], @"option", tempArray.copy, @"marked", typeArray[i], @"type", nil];
            }
            else {
                
                dict = [NSDictionary dictionaryWithObjectsAndKeys:titleArray[i], @"title", optionArray[i], @"option", selectArray[i], @"marked", typeArray[i], @"type", nil];
            }
            [arrayM addObject:dict];
        }
    }
    return arrayM.copy;
}

/**
 *  计算高度
 */
+ (CGFloat)heightForString:(NSString*)string width:(CGFloat)width fontSize:(CGFloat)fontSize oneLineHeight:(CGFloat)oneLineHeight{
    
    CGFloat lineHeight = oneLineHeight ? oneLineHeight : 44;
    CGRect rect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil];
    
    return rect.size.height > lineHeight ? rect.size.height : lineHeight;
}

@end
