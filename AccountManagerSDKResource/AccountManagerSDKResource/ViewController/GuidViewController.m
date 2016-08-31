//
//  ViewController.m
//  MyLoginTest
//
//  Created by Mr.LuDashi on 16/8/26.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import "GuidViewController.h"
#import "MainViewController.h"

@interface GuidViewController ()

@property (nonatomic, strong) LoginAPI *loginAPI;
@end

@implementation GuidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginAPI = [LoginAPI shareManager];
}

- (IBAction)tapLogin:(id)sender {
    [self checkHaveLogin];
}

- (void)checkHaveLogin {
    
    if (_loginAPI != nil) {
        __weak typeof (self) weak_self = self;
        [_loginAPI checkHaveLogin:^(NSString *token) {
            [weak_self presentMainViewControllerWithText:token];
        } noAccountBlock:^{
            [weak_self presentLoginViewController];
        }];
    }
}

- (void)presentLoginViewController {
    
    __weak typeof (self) weak_self = self;
    UIViewController *vc = [_loginAPI getLoginViewController:^(NSString *token) {
        [weak_self presentMainViewControllerWithText:token];
    }];
    
    [self presentViewController:vc animated:YES completion:^{}];
}

- (void)presentMainViewControllerWithText: (NSString *)text {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    MainViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    [vc setTipLableText:[NSString stringWithFormat:@"登录成功: %@", text]];
    [self presentViewController:vc animated:NO completion:^{
        
    }];
}



- (void)tipText: (NSString *) text {
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
