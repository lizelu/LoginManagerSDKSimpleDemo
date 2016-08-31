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

#define LOGOUT_KEY_TAG @"LogoutKeyTag" // 0-注销，1-已登录
#define HAVE_LOGIN @"1"
#define NO_LOGIN @"0"

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
        [self setLoginTag];
    }
    return self;
}

- (void)checkHaveLogin: (LoginBlock)loginSuccessBlock
        noAccountBlock: (NoAccountLoginBlock) noAccountBlock {
    //判断用户是否已注销
    if ([self isLogout]) {
        noAccountBlock();
        return;
    }
    
    [[AccountManager shareManager] checkHaveLogin:^(NSString *token) {
        loginSuccessBlock(token);
        [self setLoginTag];
    } noAccountBlock:^{
        noAccountBlock();
    }];
}

- (UIViewController *)getLoginViewController: (LoginBlock) loginBlock {
    //LoginViewController *loginVC = (LoginViewController *)[self getVCFromMainBundle];
    LoginViewController *loginVC = (LoginViewController *)[self getVCFromLoginSDKBundle];
    
    [loginVC setLoginResult:^(NSString *token) {
        loginBlock(token);
        self.token = token;
        [self setLoginTag];
    }];
    
    return loginVC;
}


- (void)logout {
    [[NSUserDefaults standardUserDefaults] setObject:NO_LOGIN forKey:LOGOUT_KEY_TAG];
}

/**
 *  判断是否已注销
 *
 *  @return YES - 已注销， NO - 已登录
 */
- (Boolean)isLogout {
    NSString *tag = [[NSUserDefaults standardUserDefaults] objectForKey:LOGOUT_KEY_TAG];
    if (tag != nil) {
        if ([tag isEqualToString:HAVE_LOGIN]) {
            return NO;
        } else {
            return YES;
        }
    }
    return YES;
}

- (void)setLoginTag {
    [[NSUserDefaults standardUserDefaults] setObject:HAVE_LOGIN forKey:LOGOUT_KEY_TAG];
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
