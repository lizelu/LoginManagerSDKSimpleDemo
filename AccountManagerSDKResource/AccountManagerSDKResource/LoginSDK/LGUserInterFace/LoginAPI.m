//
//  LoginVCManager.m
//  MyLoginTest
//
//  Created by Mr.LuDashi on 16/8/26.
//  Copyright © 2016年 ZeluLi. All rights reserved.
//

#import "LoginAPI.h"
#import "LoginViewController.h"
#import "AccountManager.h"
#define MYBUNDLE_NAME   @"LoginSDKResource.bundle"
#define MYBUNDLE_PATH   [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE        [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface LoginAPI()
@end

@implementation LoginAPI
+ (instancetype)shareManager {
    static LoginAPI * loginManagerObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loginManagerObject = [[self alloc] init];
    });
    return loginManagerObject;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}


- (void)checkHaveLogin: (LoginBlock)loginSuccessBlock
        noAccountBlock: (NoAccountLoginBlock) noAccountBlock {
    [[AccountManager shareManager] checkHaveLogin:^(NSString *token) {
        loginSuccessBlock(token);
    } noAccountBlock:^{
        noAccountBlock();
    }];
}


- (UIViewController *)getLoginViewController: (LoginBlock) loginBlock
                                failureBlock: (LoginFailureBlock) failBlock {
    NSString *bundleName =  @"LoginSDKResource.bundle";
    NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: bundleName];
    NSBundle *resourceBundle = [NSBundle bundleWithPath: bundlePath];
    
    NSLog(@"%@", [NSBundle allBundles]);
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"LoginSDK" bundle:resourceBundle];
    LoginViewController *loginVC = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [loginVC setLoginResult:^(NSString *token) {
        loginBlock(token);
        self.token = token;
    } failureBlock:^(NSString *errorMessage) {
        failBlock(errorMessage);
    }];
    
    return loginVC;

}

@end
