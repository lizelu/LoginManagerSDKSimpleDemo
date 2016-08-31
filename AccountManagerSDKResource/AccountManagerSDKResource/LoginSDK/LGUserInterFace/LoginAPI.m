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
#define LOGIN_SDK_BUNDLE_NAME   @"LoginSDKResource.bundle"
#define LOGIN_SDK_BUNDLE_PATH   [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: LOGIN_SDK_BUNDLE_NAME]
#define LOGIN_SDK_BUNDLE        [NSBundle bundleWithPath: LOGIN_SDK_BUNDLE_PATH]

#define LOGIN_STORYBOARD_NAME @"LoginSDK"
#define LOGIN_VIEWCONTROLLER_NAME @"LoginViewController"

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

- (instancetype)init {
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
    LoginViewController *loginVC = (LoginViewController *)[self getVCFromMainBundle];
    
    [loginVC setLoginResult:^(NSString *token) {
        loginBlock(token);
        self.token = token;
    } failureBlock:^(NSString *errorMessage) {
        failBlock(errorMessage);
    }];
    
    return loginVC;
}

- (UIViewController *)getVCFromLoginSDKBundle {
    NSLog(@"%@", [NSBundle allBundles]);
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:LOGIN_STORYBOARD_NAME bundle:LOGIN_SDK_BUNDLE];
    return [loginStoryboard instantiateViewControllerWithIdentifier:LOGIN_VIEWCONTROLLER_NAME];
}

- (UIViewController *) getVCFromMainBundle {
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:LOGIN_STORYBOARD_NAME bundle:[NSBundle mainBundle]];
    return [loginStoryboard instantiateViewControllerWithIdentifier:LOGIN_VIEWCONTROLLER_NAME];
}
@end
