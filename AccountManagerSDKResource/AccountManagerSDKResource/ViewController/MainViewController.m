//
//  MainViewController.m
//  AccountManagerSDKResource
//
//  Created by Mr.LuDashi on 16/8/31.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (strong, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setTipLableText: (NSString *)text {
    self.tipLabel.text = text;
}
- (IBAction)tapLoginOutButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
