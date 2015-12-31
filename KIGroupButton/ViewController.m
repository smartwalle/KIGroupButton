//
//  ViewController.m
//  KIGroupButton
//
//  Created by apple on 15/12/31.
//  Copyright (c) 2015年 SmartWalle. All rights reserved.
//

#import "ViewController.h"
#import "KIRadioButton.h"
#import "KICheckBox.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet KIRadioButton *radioButton1;
@property (weak, nonatomic) IBOutlet KICheckBox *checkBox1;
@property (weak, nonatomic) IBOutlet UILabel *infoLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.radioButton1 setSelected:YES];
    [self.checkBox1 setSelected:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)confirmAction:(id)sender {
    NSString *radioText = self.radioButton1.selectedButton.titleLabel.text;
    NSMutableString *checkBoxText = [@"" mutableCopy];
    for (KICheckBox *cb in self.checkBox1.selectedButtons) {
        [checkBoxText appendFormat:@"%@ ", cb.titleLabel.text];
    }
    
    [self.infoLab setText:[NSString stringWithFormat:@"选中单选项: %@ \n选中了多选项：%@", radioText, checkBoxText]];
}

@end
