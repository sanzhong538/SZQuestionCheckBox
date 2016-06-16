//
//  SZQuestionOptionCell.h
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/6/16.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZConfigure.h"

typedef void(^selectOptionButtonBack)(NSIndexPath *indexPath, NSDictionary *dict);

@interface SZQuestionOptionCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, copy) selectOptionButtonBack selectOptionButtonBack;

- (instancetype)initWithStyle:(UITableViewCellStyle)    style
              reuseIdentifier:(NSString *)              reuseIdentifier
                      andDict:(NSDictionary *)          contentDict
                 andIndexPath:(NSIndexPath *)           indexPath
                     andWidth:(CGFloat)                 width
                 andConfigure:(SZConfigure *)           configure;

@end
