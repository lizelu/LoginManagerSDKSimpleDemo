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

-(void)viewDidAppear:(BOOL)animated {
    //[self checkHaveLogin:NO];
}

- (IBAction)tapLogin:(id)sender {
    [self checkHaveLogin:YES];
}

- (void)checkHaveLogin: (BOOL)isTapButton {
    
    if (_loginAPI != nil) {
        __weak typeof (self) weak_self = self;
        [_loginAPI checkHaveLogin:^(NSString *token) {
            [weak_self presentMainViewControllerWithText:token];
        } noAccountBlock:^{
            if (isTapButton) {
                [weak_self presentLoginViewController];
            }
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
