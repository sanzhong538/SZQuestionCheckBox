//
//  SZConfigure.h
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/5/26.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BUTTON_WIDTH 30
#define HEADER_MARGIN 10
#define OPTION_MARGIN 20
#define OPEN_OPTION_CELL_H 44
#define WIDTH (self.frame.size.width)
#define HEIGHT (self.frame.size.height)

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
 *  单独设定多选选中时的图片名
 */
@property (nonatomic, copy) NSString *multipleCheckedImage;

/**
 *  单独设定多选未选中时的图片名
 */
@property (nonatomic, copy) NSString *multipleUncheckedImage;

/**
 *  背景颜色
 */
@property (nonatomic, strong) UIColor *backColor;

/**
 *  自动添加题号，默认 NO
 */
@property (nonatomic, assign) BOOL automaticAddLineNumber;

/**
 *  cell 的背景图片
 */
@property (nonatomic, copy) NSString *cellBackgroundImage;

/**
 *  主观题的回答框，默认NO 用UITextField，设置YES 用 UITextView
 */
@property (nonatomic, assign) BOOL answerFrameUseTextView;

/**
 *  主观题的回答框用 UITextView 时，限制自适最高高度
 */
@property (nonatomic, assign) CGFloat answerFrameLimitHeight;

/**
 *  主观题的回答框用 UITextView 时，限制固定高度
 */
@property (nonatomic, assign) CGFloat answerFrameFixedHeight;


@end
