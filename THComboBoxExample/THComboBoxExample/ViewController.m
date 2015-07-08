//
//  ViewController.m
//  THComboBoxExample
//
//  Created by wujy on 15/7/8.
//  Copyright (c) 2015年 清华大学. All rights reserved.
//

#import "ViewController.h"
#import "THComboBox.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet THComboBox *comboBox;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.comboBox.listItems = @[@"主楼",@"学堂",@"文图",@"东门"];
    self.comboBox.maxRows = 3;
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)comboBox:(THComboBox *)comboBox didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%@",self.comboBox.listItems[indexPath.row]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
