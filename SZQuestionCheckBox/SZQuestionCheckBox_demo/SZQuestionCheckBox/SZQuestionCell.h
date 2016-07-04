//
//  SZQuestionCell.h
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/4/28.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SZConfigure;

typedef void(^selectOptionBack)(NSInteger index, NSDictionary *dict, BOOL refresh);

@interface SZQuestionCell : UITableViewCell

@property (nonatomic, copy) selectOptionBack selectOptionBack;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                      andDict:(NSDictionary *)contentDict
               andQuestionNum:(NSInteger)questionNum
                     andWidth:(CGFloat)width
                 andConfigure:(SZConfigure *)configure;

@end
