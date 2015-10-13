//
//  THComboBox.m
//  THComboBoxExample
//
//  Created by wujy on 15/7/8.
//  Copyright (c) 2015年 清华大学. All rights reserved.
//

#import "THComboBox.h"
@interface THComboBox()
{
    UIButton *button;
    UIButton *dropArrow;
    UITableView *dropListTableView;
    CGFloat heightDrop;
}
@end

@implementation THComboBox
/**
 *  运行时初始化
 *
 *  @param aDecoder <#aDecoder description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup{
//#if !TARGET_INTERFACE_BUILDER
//    NSBundle *bundle = [NSBundle mainBundle];
//#else
//    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//#endif
    button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
    dropArrow = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame), 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
    [button.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CGFloat vInset = self.bounds.size.height / 5;
    CGFloat hInset = self.bounds.size.height / 8;
    dropArrow.imageEdgeInsets = UIEdgeInsetsMake(vInset, hInset, vInset, hInset);
    [self addSubview:button];
    [self addSubview:dropArrow];
    
    [dropArrow addTarget:self action:@selector(dropdownClick:) forControlEvents:UIControlEventTouchDown];
    //下拉框设置
    dropListTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, button.bounds.size.height, CGRectGetWidth(self.bounds), 0)];
    dropListTableView.layer.borderWidth = 1.0;
    dropListTableView.layer.borderColor = [[UIColor blackColor] CGColor];
    dropListTableView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    dropListTableView.rowHeight = button.bounds.size.height;
    //self.layer.borderWidth = _borderWidth;
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    dropListTableView.delegate = self;
    dropListTableView.dataSource = self;
//    _listItems = @[@"主楼",@"学堂",@"文图"];
//    [button setTitle:_listItems[0] forState:UIControlStateNormal];
    if (!_listItems) {
        [button setTitle:@"调试" forState:UIControlStateNormal];
    }
    CGFloat fontsize = ( button.bounds.size.height * 3.0f / 7.0f);
    [button.titleLabel setFont:[UIFont systemFontOfSize:(CGFloat)fontsize]];
    [self addSubview:dropListTableView];
}
/**
 *  下拉事件
 *
 *  @param sender <#sender description#>
 */
-(void)dropdownClick:(id)sender{
    if (!_maxRows) {
        heightDrop = _listItems.count > 5 ? (5 * dropListTableView.rowHeight + .2f * button.bounds.size.height) : (dropListTableView.rowHeight * _listItems.count + .2f * button.bounds.size.height);
    }
    if (dropListTableView.frame.size.height == 0) {
        [dropListTableView reloadData];
        [UIView animateWithDuration:.25 animations:^{
            [dropListTableView setFrame:CGRectMake(0,dropListTableView.frame.origin.y, dropListTableView.frame.size.width, heightDrop)];
            CGRect frameTemp = self.frame;
            frameTemp.size.height = button.frame.size.height + heightDrop;
            self.frame = frameTemp;
        }completion:^(BOOL finished){
            
        }];
    }else{
        [UIView animateWithDuration:.25 animations:^{
            [dropListTableView setFrame:CGRectMake(0,dropListTableView.frame.origin.y, dropListTableView.frame.size.width, 0)];
            CGRect frameTemp = self.frame;
            frameTemp.size.height = button.frame.size.height + 0;
            self.frame = frameTemp;
        }completion:^(BOOL finished){
            
        }];
    }
}
/**
 *  IB调试初始化
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
/**
 *  改变frame时会调用，方便IB中调试
 */
-(void)prepareForInterfaceBuilder{
    [self updateFrame];
}
/**
 *  用于IB中调试
 */
- (void)updateFrame{
    [button setFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
    [dropArrow setFrame: CGRectMake(CGRectGetWidth(self.frame) - CGRectGetHeight(self.frame), 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
    CGFloat vInset = self.bounds.size.height / 5;
    CGFloat hInset = self.bounds.size.height / 8;
    dropArrow.imageEdgeInsets = UIEdgeInsetsMake(vInset, hInset, vInset, hInset);
    CGFloat fontsize = ( button.bounds.size.height * 3.0f / 7.0f);
    [button.titleLabel setFont:[UIFont systemFontOfSize:(CGFloat)fontsize]];
}
#pragma mark - Property Settings
/**
 *  设置圆角属性
 *
 *  @param cornerRadius 圆角半径
 */
-(void)setCornerRadius:(CGFloat)cornerRadius{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius > 0?true:false;
}

/**
 *  设置下拉框最大行数
 *
 *  @param maxRows <#maxRows description#>
 */
-(void)setMaxRows:(NSInteger)maxRows{
    _maxRows = maxRows;
    if (!_maxRows) {
        _maxRows = _listItems.count;
    }
    if (_maxRows <= _listItems.count) {
        heightDrop = dropListTableView.rowHeight * _maxRows + .2f * button.bounds.size.height;
    }else{
        heightDrop = dropListTableView.rowHeight * _listItems.count + .2f * button.bounds.size.height;
    }
}
/**
 *  设置下拉按钮图像
 *
 *  @param arrowImage <#arrowImage description#>
 */
-(void)setArrowImage:(UIImage *)arrowImage{
    _arrowImage = arrowImage;
    [dropArrow setImage:arrowImage forState:UIControlStateNormal];
}
/**
 *  设置边界线线宽
 *
 *  @param borderWidth <#borderWidth description#>
 */
-(void)setBorderWidth:(CGFloat)borderWidth{
    _borderWidth = borderWidth;
    self.layer.borderWidth = borderWidth;
}
/**
 *  设置边界线颜色
 *
 *  @param borderColor <#borderColor description#>
 */
-(void)setBorderColor:(UIColor *)borderColor{
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
    dropListTableView.layer.borderColor = _borderColor.CGColor;
}
/**
 *  设置下拉菜单内容
 *
 *  @param listItems <#listItems description#>
 */
-(void)setListItems:(NSArray *)listItems{
    _listItems = listItems;
    [button setTitle:@"" forState:UIControlStateNormal];
}
/**
 *  设置文本颜色
 *
 *  @param textColor <#textColor description#>
 */
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    [button setTitleColor:_textColor forState:UIControlStateNormal];
}
/**
 *  调试文本
 *
 *  @param testString <#testString description#>
 */
-(void)setTestString:(NSString *)testString{
    _testString = testString;
    [button setTitle:_testString forState:UIControlStateNormal];
}
#pragma mark - tableview delegate and datasource
//section数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//section行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _listItems.count;
}
//行元素
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ComboCell";
    UITableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    //cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = _listItems[indexPath.row];
    return cell;
}
//选择事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [button setTitle:_listItems[indexPath.row] forState:UIControlStateNormal];
    [self dropdownClick:dropArrow];
    [self.delegate comboBox:self didSelectRowAtIndexPath:indexPath];
}
@end
