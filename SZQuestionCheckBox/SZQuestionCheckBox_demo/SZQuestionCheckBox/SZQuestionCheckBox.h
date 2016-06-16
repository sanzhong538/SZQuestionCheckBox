//
//  SZQuestionCheckBox.h
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/4/27.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZConfigure.h"
#import "SZQuestionItem.h"

typedef NS_ENUM(NSInteger, QuestionCheckBoxType) {
    QuestionCheckBoxWithHeader = 1,
    QuestionCheckBoxWithoutHeader
};

@interface SZQuestionCheckBox : UITableViewController

/*
 * 能否编辑选择, 默认为YES
 */
@property (nonatomic, assign) BOOL canEdit;

/*
 * 资源数组
 */
@property (nonatomic, strong) NSArray *sourceArray;

/*
 * 是否完成
 */
@property (nonatomic, assign, readonly) BOOL isComplete;

/*
 * 结果返回数组
 */
@property (nonatomic, strong, readonly) NSArray *resultArray;

/**
 *  构造方法 -- 默认设置
 *
 *  @param questionItem 资源模型
 *
 *  @return
 */
- (instancetype)initWithItem:(SZQuestionItem *)questionItem;

/**
 *  构造方法 -- 自定义设置
 *
 *  @param questionItem 资源模型
 *  @param configure    配置信息
 *
 *  @return 
 */
- (instancetype)initWithItem:(SZQuestionItem *)questionItem andConfigure:(SZConfigure *)configure;

/**
 *  构造方法
 *
 *  @param questionItem 资源模型
 *  @param checkBoxType 布局类型
 *
 *  @return
 */
- (instancetype)initWithItem:(SZQuestionItem *)questionItem andCheckBoxType:(QuestionCheckBoxType)checkBoxType;

/**
 *  构造方法
 *
 *  @param questionItem 资源模型
 *  @param checkBoxType 布局类型
 *  @param configure    配置信息
 *
 *  @return
 */
- (instancetype)initWithItem:(SZQuestionItem *)questionItem andCheckBoxType:(QuestionCheckBoxType)checkBoxType andConfigure:(SZConfigure *)configure;

@end
