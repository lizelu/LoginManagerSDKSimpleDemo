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
@property (strong, nonnull) NSString *tipLableString;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    self.tipLabel.text = _tipLableString;
}

- (void)setTipLableText: (NSString *)text {
    self.tipLableString = text;
}
- (IBAction)tapLoginOutButton:(id)sender {
    
    [[LoginAPI shareManager] logout];
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
