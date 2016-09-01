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
    _loginAPI = [LoginAPI shareManager];        //获取LoginAPI单例
}

- (IBAction)tapLogin: (id)sender {
    [self checkHaveLogin:YES];
}

//检查是否已经登录
- (void)checkHaveLogin: (BOOL)isTapButton {
    if (_loginAPI != nil) {
        __weak typeof (self) weak_self = self;
        [_loginAPI checkHaveLogin:^(NSString *token) {
            [weak_self presentMainViewControllerWithText:token];    //二次登录，成功后直接进入首页
        } noAccountBlock:^{
            if (isTapButton) {
                [weak_self presentLoginViewController];             //首次登录，获取登录页面，进行登录
            }
        }];
    }
}

//通过loginAPI获取登录页面，并对登录成功后的事件进行处理
- (void)presentLoginViewController {
    __weak typeof (self) weak_self = self;
    UIViewController *vc = [_loginAPI getLoginViewController:^(NSString *token) {
        [weak_self presentMainViewControllerWithText:token];
    }];
    [self presentViewController:vc animated:YES completion:^{}];
}



-(void)viewDidAppear:(BOOL)animated {
    //[self checkHaveLogin:NO];
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
