//
//  ViewController.m
//  THComboBoxExample
//
//  Created by wujy on 15/7/8.
//  Copyright (c) 2015年 清华大学. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet THComboBox *comboBox1;

@property (strong ,nonatomic) THComboBox *comBox2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.comboBox1.listItems = @[@"主楼",@"学堂",@"文图",@"东门"];
    self.comboBox1.maxRows = 3;
    self.comboBox1.delegate = self;
    
    THComboBox *comboBox1 = [[THComboBox alloc] initWithFrame:CGRectMake(200, 400, 210, 60)];
    comboBox1.listItems = @[@"ob-c",@"java",@"c#",@"c++"];
    comboBox1.borderColor = [UIColor greenColor];
    comboBox1.borderWidth = 2.0f;
    comboBox1.cornerRadius = 10.0f;
    comboBox1.arrowImage = [UIImage imageNamed:@"drop_arrow"];
    comboBox1.delegate = self;
    [self.view addSubview:comboBox1];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)comboBox:(THComboBox *)comboBox didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (comboBox == self.comboBox1) {
        NSLog(@"%@",comboBox.listItems[indexPath.row]);
    }else{
        NSLog(@"other:%@",comboBox.listItems[indexPath.row]);
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
