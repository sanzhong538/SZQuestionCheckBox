//
//  SZQuestionCell.h
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/4/28.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SZConfigure;

#define BUTTON_WIDTH 30
#define HEADER_MARGIN 10
#define OPTION_MARGIN 20
#define OPEN_OPTION_CELL_H 44
#define WIDTH (self.frame.size.width)
#define HEIGHT (self.frame.size.height)

typedef void(^selectOptionBack)(NSInteger index, NSDictionary *dict);

@interface SZQuestionCell : UITableViewCell

@property (nonatomic, copy) selectOptionBack selectOptionBack;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andDict:(NSDictionary *)contentDict andQuestionNum:(NSInteger)questionNum andWidth:(CGFloat)width andConfigure:(SZConfigure *)configure;

@end
