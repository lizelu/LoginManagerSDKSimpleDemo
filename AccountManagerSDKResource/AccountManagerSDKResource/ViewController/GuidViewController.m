//
//  ViewController.m
//  MyLoginTest
//
//  Created by Mr.LuDashi on 16/8/26.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import "GuidViewController.h"
#import "LoginAPI.h"

@interface GuidViewController ()
@property (strong, nonatomic) IBOutlet UILabel *loginStateLabel;
@property (nonatomic, strong) LoginAPI *loginAPI;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginAPI = [LoginAPI shareManager];
    [self checkHaveLogin];
}

- (void)checkHaveLogin {
    if (_loginAPI != nil) {
        __weak typeof (self) weak_self = self;
        [_loginAPI checkHaveLogin:^(NSString *token) {
            [weak_self tipText:[NSString stringWithFormat:@"二次登录成功：token = %@", token]];
        } noAccountBlock:^{
            [weak_self tipText:@"尚未有账号在此设备上登录过"];
        }];
    }
}

- (IBAction)tapLogin:(id)sender {
     __weak typeof (self) weak_self = self;
    UIViewController *vc = [_loginAPI getLoginViewController:^(NSString *token) {
        [weak_self tipText:[NSString stringWithFormat:@"首次登录成功：token = %@", token]];
    } failureBlock:^(NSString *errorMessage) {
        [weak_self tipText:errorMessage];
    }];
    
    [self presentViewController:vc animated:YES completion:^{}];
}


- (void)tipText: (NSString *) text {
    self.loginStateLabel.text = text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
