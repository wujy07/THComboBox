//
//  THComboBox.h
//  THComboBoxExample
//
//  Created by wujy on 15/7/8.
//  Copyright (c) 2015年 清华大学. All rights reserved.
//

#import <UIKit/UIKit.h>

//委托协议
@class THComboBox;
@protocol ComboBoxDelegate <NSObject>
-(void)comboBox:(THComboBox *)comboBox didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

IB_DESIGNABLE
@interface THComboBox : UIView<UITableViewDataSource,UITableViewDelegate>
//可在IB中属性调整
@property (nonatomic) IBInspectable CGFloat cornerRadius;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable UIColor *borderColor;
@property (nonatomic) IBInspectable UIImage *arrowImage;
@property (nonatomic) IBInspectable UIColor *textColor;
@property (nonatomic) IBInspectable NSString *testString;

@property (nonatomic)   NSInteger maxRows;
@property (strong, nonatomic) NSArray *listItems;
@property (strong, nonatomic) id<ComboBoxDelegate> delegate;
@end
