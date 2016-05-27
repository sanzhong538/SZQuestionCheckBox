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
 *  构造方法
 *
 *  @param questionItem 资源模型
 *
 *  @return
 */
- (instancetype)initWithItem:(SZQuestionItem *)questionItem;

/**
 *  构造方法
 *
 *  @param questionItem 资源模型
 *  @param configure    配置信息
 *
 *  @return 
 */
- (instancetype)initWithItem:(SZQuestionItem *)questionItem andConfigure:(SZConfigure *)configure;

@end
