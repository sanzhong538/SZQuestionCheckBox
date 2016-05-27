//
//  SZQuestionCheckBox.m
//  SZQuestionCheckBox_demo
//
//  Created by 吴三忠 on 16/4/27.
//  Copyright © 2016年 吴三忠. All rights reserved.
//

#import "SZQuestionCheckBox.h"
#import "SZQuestionCell.h"

@interface SZQuestionCheckBox ()

@property (nonatomic, assign) CGFloat titleWidth;

@property (nonatomic, assign) CGFloat OptionWidth;

@property (nonatomic, assign) BOOL complete;

@property (nonatomic, strong) NSArray *tempArray;

@property (nonatomic, strong) NSMutableArray *arrayM;

@property (nonatomic, strong) SZConfigure *configure;

@end

@implementation SZQuestionCheckBox

- (instancetype)initWithItem:(SZQuestionItem *)questionItem andConfigure:(SZConfigure *)configure {
    
    self = [super init];
    
    if (self) {
        self.sourceArray = questionItem.ItemQuestionArray;
        if (configure != nil) self.configure = configure;
    }
    return self;
}

- (instancetype)initWithItem:(SZQuestionItem *)questionItem {
    
    return [self initWithItem:questionItem andConfigure:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.canEdit = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.titleWidth = self.view.frame.size.width - (self.configure.titleSideMargin ? self.configure.titleSideMargin * 2 : HEADER_MARGIN * 2);
    self.OptionWidth = self.view.frame.size.width - (self.configure.optionSideMargin ? self.configure.optionSideMargin * 2 : OPTION_MARGIN * 2) - (self.configure.buttonSize ? self.configure.buttonSize : BUTTON_WIDTH - 5);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)isComplete {
    
    [self getResult];
    return self.complete;
}

- (NSArray *)resultArray {
    
    [self getResult];
    return self.tempArray;
}

- (void)getResult {
    
    BOOL complete = true;
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in self.sourceArray) {
        
        if ([dict[@"type"] integerValue] == SZQuestionOpenQuestion) {
            NSString *str = dict[@"marked"];
            complete = (str.length > 0) && complete;
            [arrayM addObject:str.length ? dict[@"marked"] : [NSNull null]];
        }
        else {
            NSArray *array = dict[@"marked"];
            complete = ([array containsObject:@"YES"] || [array containsObject:@"yes"] || [array containsObject:@(1)] || [array containsObject:@"1"]) && complete;
            [arrayM addObject:dict[@"marked"]];
        }
    }
    self.complete = complete;
    self.tempArray = arrayM.copy;
}

- (void)setCanEdit:(BOOL)canEdit {
    
    _canEdit = canEdit;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.sourceArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *dict = self.sourceArray[indexPath.row];
    SZQuestionCell *cell = [[SZQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"questionCellIdentifier" andDict:dict andQuestionNum:indexPath.row + 1 andWidth:self.view.frame.size.width andConfigure:self.configure];
    __weak typeof(self) weakSelf = self;
    cell.selectOptionBack = ^(NSInteger index, NSDictionary *dict) {
        [weakSelf.arrayM replaceObjectAtIndex:index withObject:dict];
        weakSelf.sourceArray = weakSelf.arrayM.copy;
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.userInteractionEnabled = self.canEdit;
    
    return cell;
}

/**
 *  返回各个Cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat topDistance = 0;
    
    if (indexPath.row == 0) {
        topDistance = self.configure.topDistance;
    }
    
    NSDictionary *dict = self.sourceArray[indexPath.row];
    
    if ([dict[@"type"] intValue] == SZQuestionOpenQuestion) {
        
        CGFloat title_height = [SZQuestionItem heightForString:dict[@"title"] width:self.titleWidth fontSize:self.configure.titleFont ? self.configure.titleFont : 17 oneLineHeight:self.configure.oneLineHeight];
        return title_height + (self.configure.oneLineHeight ? self.configure.oneLineHeight : 44) + topDistance;
    }
    else {
        
        CGFloat title_height = [SZQuestionItem heightForString:dict[@"title"] width:self.titleWidth fontSize:self.configure.titleFont ? self.configure.titleFont : 17 oneLineHeight:self.configure.oneLineHeight];
        CGFloat option_height = 0;
        for (NSString *str in dict[@"option"]) {
            option_height += [SZQuestionItem heightForString:str width:self.OptionWidth fontSize:self.configure.optionFont ? self.configure.optionFont : 16 oneLineHeight:self.configure.oneLineHeight];
        }
        return title_height + option_height + topDistance;
    }
}

/**
 *  计算高度
 */
//-(CGFloat)heightForString:(NSString*)string isTitle:(BOOL)isTitle
//{
//    CGRect rect = [string boundingRectWithSize:CGSizeMake(isTitle ? self.titleWidth : self.OptionWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:isTitle ? self.fontSize : self.fontSize - 1]} context:nil];
//    
//    return rect.size.height > 44 ? rect.size.height : 44;
//}

#pragma mark - 懒加载

- (NSMutableArray *)arrayM {
    
    if (_arrayM == nil) {
        _arrayM = [[NSMutableArray alloc] initWithArray:self.sourceArray];
    }
    return _arrayM;
}

@end
