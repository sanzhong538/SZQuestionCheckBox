//
//  SZConfigure.h
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/5/26.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZConfigure : NSObject

/**
 *  标题字体大小
 */
@property (nonatomic, assign) CGFloat titleFont;

/**
 *  选项字体大小
 */
@property (nonatomic, assign) CGFloat optionFont;

/**
 *  标题字体颜色
 */
@property (nonatomic, strong) UIColor *titleTextColor;

/**
 *  选项字体颜色
 */
@property (nonatomic, strong) UIColor *optionTextColor;

/**
 *  单行的高度
 */
@property (nonatomic, assign) CGFloat oneLineHeight;

/**
 *  顶部距离
 */
@property (nonatomic, assign) CGFloat topDistance;

/**
 *  标题边距
 */
@property (nonatomic, assign) CGFloat titleSideMargin;

/**
 *  选项边距
 */
@property (nonatomic, assign) CGFloat optionSideMargin;

/**
 *  按钮大小
 */
@property (nonatomic, assign) CGFloat buttonSize;

/**
 *  选中时的图片名
 */
@property (nonatomic, copy) NSString *checkedImage;

/**
 *  未选中时的图片名
 */
@property (nonatomic, copy) NSString *unCheckedImage;

/**
 *  背景颜色
 */
@property (nonatomic, strong) UIColor *backColor;

@end
